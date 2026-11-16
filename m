Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855642;
	b=ZTaw4X3Nn3lW7Bk24ORSUJ+x0RjYX9DBRJfqnJAxr6EcKsCnfL7WLzsFhbxoqE948PG8
	 L4qkAxTHrR6q6iwpRzrQkzFe5SfmSj2DoPDoFiZ5rf7RX5jU/ubn34VNu7fQFO+0VMMyG
	 J/SyrdgCJzTXSxEoDJlZqA896k2wwiUgQs1Zy7bRNNc7TagMQVf+YPiB+riUpJvFpNk65
	 tNllgGfJ/GR7dHQdusacW58fmU2gJs1jUT9qIaYbwTb6COblNNPVbB9dDsDqEnf9Fhk/u
	 WnAaU7Q69wMe9QAp/LeKdxIHHlZlg0Mq9NO1Yg1Lzv1xGOjVnCv4IEqzXqUtxUYkwlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855642;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4+4U/mKmoiNXgidziepHD0mqeBrD7/JMuncFgTs4tUM=;
	b=WIIH42aL9ZieH4YmKh9Pn9EMNGntUcRmn2T1SsrknOc3mRJV/TnlVCaHEOKZx5vZVzR7
	 bC7lD60xldUruElwUIpUXlfUpbbhvnB1OVvJcHqYHcmUKCYJXd7+3zsuQCKSnYpqVoQ6J
	 Sn+vGTQcoHePKieK5s0xSFp39XifzDLeUrzuOA2GOwTr+aFRiAPJP837FPeg76ZBkX2Bj
	 HTQvLdyEjQf5Y4GXjX1gnJClqqkFvKav32vI4tAnWq8N1o1YSx4rbB2Rg+dVLc2mfL248
	 4PXY/KSZUmdLwdNEiEqufpx4tGHxDkFta/YkPJf78JGRG6gutbLkr5Kdou7eAyowuhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFWuIg6P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F1BC0606A33B;
	Mon, 16 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFWuIg6P
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 25D191F000C4;
	Mon, 16 Nov 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855641;
	bh=4+4U/mKmoiNXgidziepHD0mqeBrD7/JMuncFgTs4tUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFWuIg6P/D56dCUFXqH3xLvXVT5WgNOHihSFTI5Rhg4YkZJP8TvwEoK96mDg2Ia0T
	 A35FVNAFa5ATq4c107B5c5Qdwpma+OfrTbs0sJKS0G1npNNpz7VLW47bhY7RiCej5Z
	 YluUNaAOxbHpHeDKSwmk7CzIBjISbSl9xbaBKMrNmaOZHQbSbUvGmFqw1eNOK4qzGu
	 72LTVgPz4K5MEdmoHhlCIu0XYp9MGOjljE+mOvtOCbArK90GxD5BKaCtfOulx3Cm5b
	 GRbm2zlUmm3/YVFezD+H97zBZ1b5wAc/SYdowv/+d/lj30cTHIGUbUSbjosMotDgaq
	 oD1eYOKpnKlIw==
Date: Mon, 16 Nov 2026 14:00:40 -0500
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/6] Additional miscellaneous RCU updates for v7.5
Message-ID: <20261116190040.GA946893@joelbox>
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
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
In-Reply-To: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>

On 11/16, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> Hello!
> 
> This series provides additional miscellaneous updates for v7.5:
> 
> 1.	MAINTAINERS: Add Puranjay Mohan and RCU reviewer.
> 
> 2.	Make torture.sh test NMIs for atomic SRCU on x86.
> 
> 3.	Avoid duplicate identify_qemu_vcpus calls in torture.sh.
> 
> 4.	Make torture.sh test NMIs for RCU on x86.
> 
> 5.	Make kvm.sh ignore empty-string arguments.
> 
> 6.	Use ${:+} to save a few lines in torture.sh's torture_one().

Thanks, I will apply all except 2. and 4. as they depend on Mathieu's series
which is not going in for 7.4:
https://lore.kernel.org/all/20261112133731.127221-1-mathieu.desnoyers@efficios.com/

For the others, I have replaced patches which were already there (in 7.4 next
tree) with the new ones you sent, with updated tags.

thanks,

Joel Fernandes




> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/MAINTAINERS                                       |    1 
>  b/tools/testing/selftests/rcutorture/bin/kvm.sh     |    3 ++
>  b/tools/testing/selftests/rcutorture/bin/torture.sh |   11 ++++++---
>  tools/testing/selftests/rcutorture/bin/torture.sh   |   23 +++++++++-----------
>  4 files changed, 22 insertions(+), 16 deletions(-)
