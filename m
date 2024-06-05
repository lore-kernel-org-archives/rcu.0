Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38D19AD4D;
	Wed,  5 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588586; cv=none; b=e7Q8L3M9H+zk2jcd2xs22/SOR+g66NI7hx0AUDw28FxFvIid5DyLbQCJXkQPNUrcNRULMPjhkd91fsXstwMIGm5Pydc0dByK4qdiy/zOnwX9sbb1AB98x9f0d+0mN34nC62LhT6jKb5hp0vyAoBjTb9+mBINhkJC4+T5Wck1MbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588586; c=relaxed/simple;
	bh=MQYsWFBeAynMryk/Gyt9yTWjflv1cv5n6aWLBDe/SFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUveI+6hrT8Z94EVHuFdujwJjuhTFnxzcH1p9rwyHM2ZssiJVo/HZnNkQ2koZ+YHOZM0fN7zHmMMGK6FSgmTiJuQVBTbLCAp596vvBXLrPjNnkQm0E20JdWlYSbriS2oVS7AbgzI7YoG+NymKVYeeBT8dxYpFmUqDCZMR8ZkgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+nQWdQr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+nQWdQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA128C4AF07;
	Wed,  5 Jun 2024 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588586;
	bh=MQYsWFBeAynMryk/Gyt9yTWjflv1cv5n6aWLBDe/SFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+nQWdQr5oGfrnskMQzLWboTz7AK+E6POtbk0O+zGu+62bG5UD8QbtKGVRg8SrsMG
	 8oUBjkoDi9aPSNdSAGyuN6IMtpMrdgxhrVF+zFWmAbW42Dagp/BQn55I20stO6VNZG
	 sKAx599Yi08sXUjeA12P1rtkK82FidRX7NCo15Et0ia1HBXkssWHPVEdCjuM/ALe/0
	 V/Oik0M6CLAbwNfEeazAtG+3mhXOyaVXj5zy54ZjzZtdEPOYgUz7mXz+0O9/cGW/UN
	 zmun4M84sFxBvam+MYlG6P07r0Ornk+V7FPmDUjO1MmrLmjEQG5ODYP8dLSafi7Nvt
	 BI1g4IRc0pomg==
Date: Wed, 5 Jun 2024 13:56:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: Re: [PATCH rcu 2/2] doc: Clarify rcu_assign_pointer() and
 rcu_dereference() ordering
Message-ID: <ZmBSZ3AAp9TN5YaP@localhost.localdomain>
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
 <20240604222155.2370541-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604222155.2370541-2-paulmck@kernel.org>

Le Tue, Jun 04, 2024 at 03:21:55PM -0700, Paul E. McKenney a écrit :
> This commit expands on the ordering properties of rcu_assign_pointer()
> and rcu_dereference(), outlining their constraints on CPUs and compilers.
> 
> Reported-by: Rao Shoaib <rao.shoaib@oracle.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/RCU/whatisRCU.rst | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 94838c65c7d97..d585a5490aeec 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -250,21 +250,25 @@ rcu_assign_pointer()
>  ^^^^^^^^^^^^^^^^^^^^
>  	void rcu_assign_pointer(p, typeof(p) v);
>  
> -	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
> -	would be cool to be able to declare a function in this manner.
> -	(Compiler experts will no doubt disagree.)
> +	Yes, rcu_assign_pointer() **is** implemented as a macro, though
> +	it would be cool to be able to declare a function in this manner.
> +	(And there has been some discussion of adding overloaded functions
> +	to the C language, so who knows?)
>  
>  	The updater uses this spatial macro to assign a new value to an
>  	RCU-protected pointer, in order to safely communicate the change
>  	in value from the updater to the reader.  This is a spatial (as
>  	opposed to temporal) macro.  It does not evaluate to an rvalue,
> -	but it does execute any memory-barrier instructions required
> -	for a given CPU architecture.  Its ordering properties are that
> -	of a store-release operation.
> -
> -	Perhaps just as important, it serves to document (1) which
> -	pointers are protected by RCU and (2) the point at which a
> -	given structure becomes accessible to other CPUs.  That said,
> +	but it does provide any compiler directives and memory-barrier
> +	instructions required for a given compile or CPU architecture.
> +	Its ordering properties are that of a store-release operation,
> +	that is, any prior loads and stores required to initialize the
> +	structure are ordered before the store that publishes the pointer
> +	to that structure.

About that, why rcu_dereference() isn't a matching load-acquire?

Thanks.
