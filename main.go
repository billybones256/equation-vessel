package main

import (
	"context"
	"fmt"
	"math/big"

	pb "equation-vessel/proto/vessel"
	"github.com/micro/go-micro"
)

type Solver interface {
	IsPrime(context.Context, *pb.Specification, *pb.Response) error
}

type service struct {
	solver Solver
}

//Solve ...
func (s *service) IsPrime(ctx context.Context, req *pb.Specification, res *pb.Response) error {
	res.IsPrime = big.NewInt(int64(req.Sum)).ProbablyPrime(0)
	return nil
}

func main() {
	srv := micro.NewService(
		micro.Name("vessel"),
	)

	srv.Init()

	pb.RegisterVesselServiceHandler(srv.Server(), &service{})

	if err := srv.Run(); err != nil {
		fmt.Println(err)
	}
}
