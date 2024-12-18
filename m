Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F735949;
	Wed, 18 Dec 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553862; cv=none; b=uK0gZNGCdMYYElzS42SMssv1v0L6Z+ykaULpGyyMqK2TxxIiUfIFx0HVrTMt3NeobXTnhJ/lKBXFIiLVxk4wtPxuUBiLapm/f/XpYu4NkYcD2PW84CHZw8Zg/hedCpa5cSTcRYY7TGcpP2vRwKs6CuAHcV6rgCG4LDz7Yhuq2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553862; c=relaxed/simple;
	bh=bxu5pAffySDf+QhiyLDvlH14xCeld/HKs7MDsJ6FCfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICkT2041s9HInMXc5mfYqm2LeHIkSX54xRJvmyYE0ZEMoT+sXl7NRldyb3X7vy63/TCef+pKjpzHqlJsw63FMAVH0LKLhFB/QF4BpJdSupkXzECa+0Rj6+6ntcMWK156+8aSZSEsamP945630zDFPZkukmRzhesG78P6PTSTr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kChYw+gJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kChYw+gJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEE6C4CECD;
	Wed, 18 Dec 2024 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734553861;
	bh=bxu5pAffySDf+QhiyLDvlH14xCeld/HKs7MDsJ6FCfk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kChYw+gJLFy1OTDKOPlGDJa1S/FatBVBGLypgs3iGlxlAh6uwIsz6C5VpoBXFLWLr
	 AqNTyPgHy27ddS4kUZ84UJcbl33kDw7cRdMbta3Ki/dlBwbgFxrxPszmgoABist/zb
	 ivfInQQeA+WGufEOfJUP+Luq1m4va0iGqoj3EVheMv0nDki2EqsYls1aiozrjG4HNm
	 5x7sK2IsNHAQTMeX5gk+NRLQlH5ly1aD+BshibvT31ug3hqEfxssbcPpPhV7NR4VNS
	 PBMqQ6mukYiMoIF/rc672L2XIt8h93SWRcXOU3j5YOkH8bUPymiOrBxWZrstnD2Fhw
	 iRV3ouO53r9RA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FD05CE0E5E; Wed, 18 Dec 2024 12:31:01 -0800 (PST)
Date: Wed, 18 Dec 2024 12:31:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky>
 <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky>
 <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>

On Wed, Dec 18, 2024 at 08:33:09PM +0100, Magnus Lindholm wrote:
> Hi again,
> 
> So, various versions of GCC can trigger/untrigger the RCU bugs that
> I've been hitting. This may of course still be due to GCC miscompiling
> some code on alpha but that said I've taken another look at the code
> involved when this is triggered. From what I've seen so far, this
> happens when kernel threads are used in the code to access structured
> data stored on the stack (structs). The quote below is from a comment
> in the kernel code (include/linux/percpu-defs.h)
> 
> "s390 and alpha modules require percpu variables to be defined as weak
> to force the compiler to generate GOT based external references for
> them. This is necessary because percpu sections will be located
> outside of the usually addressable area. This definition puts the
> following two extra restrictions when defining percpu variables.
> 
> 1. The symbol must be globally unique, even the static ones.
> 
> 2. Static percpu variables cannot be defined inside a function."
> 
> 
> Taking these notes into account I've made some minor modifications to
> the code (briefly described below). The modifications involve
> declaring some structs previously placed on stack as
> DEFINE_PER_CPU_SHARED_ALIGNED. This is already done for some strucs in
> rcu/smp code. Making these modifications fixes the problem and I can
> build the kernel with GCC versions that previously triggered the bug.
> The same approach fixed both the network interface-rename bug as well
> as the scsi module unload bug.
> 
> in kernel/smp/smp.c
> -------------------
> #if  defined(ARCH_NEEDS_WEAK_PER_CPU)
> smp_call_function_single(...) use csd = this_cpu_ptr(&csd_data)
> regardless if its called with wait = 0 or 1. Make sure to declare
> csd_data as "DEFINE_PER_CPU_SHARED_ALIGNED"
> #endif

If I understand your proposed changes correctly, this could increase
the amount of time CPUs spend waiting for for the csd_data to become free.
This would be a very unwelcome development in some quarters.

> in kernel/rcu/tree.c
> --------------------
> #use rew_data instead of stack allocated struct
> static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_exp_work, rew_data);

I am not finding this one.

> in kernel/rcu/tree_exp.h
> ------------------------
> #if  defined(ARCH_NEEDS_WEAK_PER_CPU)
> void synchronize_rcu_expedited(void)
> 
> in stead of:
> struct rcu_exp_work rew;
> 
> do:
> #if  defined(ARCH_NEEDS_WEAK_PER_CPU)
> struct rcu_exp_work *rewp;
> rewp=this_cpu_ptr(&rew_data);
> 
> rew_data is declared "DEFINE_PER_CPU_SHARED_ALIGNED"
> 
> #endif

OK, I *can* find this one, thank you.  At least assuming you mean the
local variable "rew" defined in synchronize_rcu_expedited().

I don't see how this relates to the per-CPU variable restrictions called
out above relates here.  We do not have any sort of per-CPU variable here,
but instead a simple structure allocated on the stack.  And a relatively
small structure at that.

In addition, making this be a per-CPU variable will break if a given
CPU invokes a second synchronize_rcu_expedited() before its first call
to synchronize_rcu_expedited() returns.  You will end up with the second
call clobbering that per-CPU variable, which will likely fatally confuse
the workqueue when attempting to manage the resulting workqueue handlers.
You might need heavy load to make this happen, but I don't see anything
preventing it from happening.

So what am I missing here?

							Thanx, Paul
