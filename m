Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514083;
	b=yuEDP/Y9J28nYJ8NtpKYgtJquvsQyhi/ZQhBFoP+bdcUt+JPNHu5KbEkZtOxWBKTEayy
	 mAzvfvmSN+g/gBBuAPUewHf9U8rPwnXZLiTrmTxs6sMG5HaZRFp93ObiZHEMxAVCK1XZ4
	 mjPbPJeFsCx0/BzhbzkTlR+vCTgy/03CCasSScVRCoc5XJXxmZKO3OFp+DUsUfT4M6Be5
	 Z7SKMn0+waLBiJGOM7EJvKsamKuUILxo4545xKLB+Ll7N9Nhc+5eqD/rcW0QjVhg6qEJ3
	 JNNFjWYUm/jYzRuvRXgHcn+l/kANOO84iBRzLYMjnvtZHZ4tukrEgQz8GT9UlVXih9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514083;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=oS5LTizZXap4FfvjUWL2dHNcegZ/dEibKUjWK4UW7Mw=;
	b=3oEUteE3KfRdmeXzOXGY1zlEPFMwXoZ/y8bQXlrIIWMub3B7KsC06IlwfdOM6ntkfr/m
	 P7E6mM/bwd49lxHY//JPAlrMN87K7BzMoNXBM4yiqPd5aSWvOg3ueXsxGEqcwCdVTNFIb
	 ejuAEpDuIufj367yNnsd7/3gaIVtYOOZDJf+IKHredm73qudCfDTn1lXo5VZDv0SiZblG
	 gbU1e7xBPXYqqmcT6u08oZKXYFihv1afNgA69RQE+U2bUdoCW3Rr5EfX3bwoRWJeoBZbY
	 nnZgHSXXD3PFSNUMnBqmodz5S7iOA3NTK7mOFr75LZjSUbr2N/qNGongflN6rZuDkow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8DI6sCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BA606A31C;
	Thu, 12 Nov 2026 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8DI6sCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2301F000C4;
	Thu, 12 Nov 2026 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514083;
	bh=oS5LTizZXap4FfvjUWL2dHNcegZ/dEibKUjWK4UW7Mw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=K8DI6sCLkA6zir4U8oSCpjxNDPGsyaG2hIxZQ4XjMTD/OuTIKrDPKzksGqL6cixwQ
	 +oa+HCHXUYRlIf2J2VJ2kOJzTdnLYxwBFjkrGkKpbo/dPsIh/HWK6EA+jnbDRlruc3
	 KOR4ssAuOpPEJcNt85Vxu/uEkBCm9OxM1uAD1YpiV0oAOL/StVmzeO0v2olxgv51Ei
	 L+O+Kd+DCFtFbwjUIbUHCKD69hrBT6NwurZJ6pgmgwsoz6QLZYYicnvnGLvyVphVUg
	 j1JBjZ/wQg1V4fPnX+OW84uDPSz1sOyIKDqoS22bF7RQjJux59gglbKXGtXl5kteIX
	 jG7XVtaWfzCKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2D1CCE0B0B; Thu, 12 Nov 2026 12:08:02 -0800 (PST)
Date: Thu, 12 Nov 2026 12:08:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
Message-ID: <321aa8c1-59a0-4e9c-84d5-6954313a38b6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
 <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
 <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>
 <78c1a437-ee80-4e83-8806-a7f7113a4b63@paulmck-laptop>
 <b81abda5-e882-42e8-b780-6db34fdd0092@efficios.com>
 <408366d0-3612-47a2-bfce-7ee52828f3ae@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408366d0-3612-47a2-bfce-7ee52828f3ae@paulmck-laptop>

On Wed, Nov 11, 2026 at 08:25:30PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 11, 2026 at 09:50:26PM -0500, Mathieu Desnoyers wrote:
> > On 2026-11-11 21:13, Paul E. McKenney wrote:
> > [...]
> > > I used the same trick that I have used elsewhere, keeping a separate
> > > variable for the tag ("--qemu-args") and the argument itself, as shown
> > > in the diff below on top of my earlier patch.
> > [...]
> > > +             --configs "SRCU-P" "${qemu_tag}" "${qemu_args}" --trust-make
> > 
> > This works on x86.  On arm64 both variables are empty, so kvm.sh gets
> > two empty arguments.  A kvm.sh --dryrun with "" "" in that place stops
> > with:
> > 
> >     Unknown argument
> > 
> > Dropping the quotes does not help: the value has a space in it.  So I
> > think this one needs either the ${qemu_arg:+...} form, or a test around
> > the torture_set call.
> 
> Ah, you need the kvm.sh hunk of this commit in my -rcu tree:
> 
> 436f3c6b27de ("torture.sh: Add hazptr torturing")
> 
> Which I clearly need to extract from hazard pointers and get more widely
> available.  Diff shown below.

But after playing with the ${:+} syntax a bit more, sold!!!  Thank you
for the tutorial.

I will be applying that to the hazard-pointers stack as well, but keeping
the forgiveness of empty arguments just in case.

							Thanx, Paul

> > > I will add it there, also.
> > > 
> > > And to the --do-rcutorture stuff as well.
> > 
> > Sounds good.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index 32c3199976388..86dd5c131d226 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -271,6 +271,9 @@ do
>  	--trust-make)
>  		TORTURE_TRUST_MAKE="y"
>  		;;
> +	"")
> +		# torture.sh can pass empty arguments.  Ignore them.
> +		;;
>  	*)
>  		echo Unknown argument $1
>  		usage
> 
