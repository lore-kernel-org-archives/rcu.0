Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E52AD21;
	Tue, 31 Dec 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735641847; cv=none; b=EMThQmiwFa0hPvw/4zHHntTJlHawCvEflSxajJ9hSEH63JqkHoRUchLs3oXWn21AsZkwKc45TiKRGRb2v/xHQBqqY0pD78P6T5+gZ/1ZfalFY4xQ5vNlzRXplCPCEOxuQfbalSHGdNiIZIpphQKGB24LwhsfwwgvBEWEPWCVT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735641847; c=relaxed/simple;
	bh=hNZsV7aVjTO/Oph2EizHE3xYkG5ABVePahNQhFajo1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7TmC7ZO6BylLsdqp0GqjpPg2EezGXvpsM/ZKFoalr4eJZe3sW85lDHXi9ArND+NhgEG/K1fvh7GdDn5JAQ4Ip5JAAxm7zY+imSSoXzvvHtxwJXevE+8j3vLPJXpXJcFhL/laFzF2c8pdGbTK54MkMhEdC66ITvVQ2F6EiBIagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWnb6aqF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWnb6aqF"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so16974458a12.2;
        Tue, 31 Dec 2024 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735641844; x=1736246644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46Xla2ZNkq9B6Ti87RIET4GniW6M+MRvF1zbc9kqi58=;
        b=JWnb6aqF06Sivbcq6UGMQMwROfwYwkGAp3tQkWTkTMLYT0p74OlsDEEsZKv5TStmpy
         ADWOacJ8puGIqdBu/paflsm6cnck1Q8ZpJwp2q+QhBEPgNxv6bUcMyFtN2x/ABQ8jd0N
         zcMnvbqAm/zPVp5auFGXRuOXR4SkMULW7LFHjnynUVnxQ4UTGNpNxvCzJot4e5n5Pdsj
         11BqKOr7GYyrpvzRony1v/k4lv2Q6I+XcQybGiDcmfLB92EMd5rXW/chWVTLV/Wl89A8
         g+BORszFLE9id0+EHb1GuR0RCGpEgbvEi/UAkJVSxF9gxXP5RoezDDMRVcodKsOxp08M
         /fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735641844; x=1736246644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Xla2ZNkq9B6Ti87RIET4GniW6M+MRvF1zbc9kqi58=;
        b=ij2S+SPLQ1CUrda6ZgpqmO7aCcSFN35N6lHz4p50ThGO5xQvVM+jHz4e7/8erB1BbZ
         MXPHoLgLqp+9J0iuPow6lftLfG6i7LU/4UeTVHVqDz8B17d1qyVsNFIY9TwolFXo5wY8
         WhM4IPHg8bL/hlseeOMTdXi3E52hEnWMK9+Y6xFYEENcyBqhXUJUl5+umzDwPFydueyr
         qTis3KV4vCSCpDz8dU89hxsnEIXnXGZCkCLWRFaCbnvrqeENux5+sLAqmltCe0Gk0ZJz
         XsEF8qnEITdx0yVnW5wGAxUCca/gMRnpOPpehLp6oRwz1icS0ZpcEiB6ToL3hMJF87JB
         IxBA==
X-Forwarded-Encrypted: i=1; AJvYcCUhFWtNtsKLWsqzvXkBNUqAahFyBgUE0HfSjOCek7NzoYCbrIyIp5GZtgRSuXKdetB/WusrgBWY2LVQow==@vger.kernel.org, AJvYcCWshU/b6sRKpthhxXwjjRJefAC+ep9727fE2C0n5cEKLLKK0rWYBUsxhnbOpQHD4p0I4/zr@vger.kernel.org
X-Gm-Message-State: AOJu0YwPo48o0NN1a0wpjFFozo5zaReJldry3+QcedjRZuRB15JjYesW
	wm/8F6tGJEmU6JCwyllLD6Sh6v//fSDwVMnMAQz5th/PHHAw2+V4koyAE5qyC7T9AkPr22WjMWc
	xcwk7sIjkqEEh1JwgxBhSavlM1RctCRFE
X-Gm-Gg: ASbGncuN0Kyc2DHlFVtAsM0S3Ddmf4eRwkOjnEGfo47YmOMCZwfZ5OrsIu6eREZIOv7
	cPfZMqHj8h4rLVL2DX4R/rD8qm5fEdLVfUTre0jM=
X-Google-Smtp-Source: AGHT+IFNidcOZt+HfMjbfCYmZlVoBvuecrRgk1pDdmuUMHHEDJ9NyBDCvxr9lkErpUTcOqo5rnKDp3HdBNkHEMp4AUc=
X-Received: by 2002:a17:907:368a:b0:aa6:b473:8500 with SMTP id
 a640c23a62f3a-aac3355fe3fmr3229307566b.42.1735641843939; Tue, 31 Dec 2024
 02:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
 <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop> <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>
 <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop> <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
 <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com> <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 31 Dec 2024 11:43:52 +0100
Message-ID: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  Umm, no.  The psABI guarantees 16-byte alignment for the stack pointer,
> and under this condition (((x - 17) & ~31) + 32 <= x) is guaranteed to be
> true (except for the overflow case, of course, which does not apply here).

aha! that explains it! thanks, is the psABI available somewhere?

>
>  Would you be able to trace it back further, e.g. by adding BUG_ON(!node)
> to `__smp_call_single_queue' and so on if required, to see where this NULL
> pointer comes from originally?  I do hope such a minimal probe won't
> disturb code generation enough for this to become a heisenbug.
>
Hi, below are some additional test that I've made,

It seems to me that part of the stack is overwritten with the values
of other local variables. Previously this affected the return address
on the stack causing kernels Oops on function return (see previous
mail in thread). In this run it seems like when the pointer *csd in
smp_call_function_single is stored on the stack, it gets overwritten
by writes to csd_stack.info. The difference here is that I use GCC
15.0.0 20241225 (experimental) instead of gcc (Gentoo 14.2.1_p20241116
p3) 14.2.1. To me, this looks like the same problem but the clobbering
just hits a different part of the stack. Below is some debug-output,
where I've added some print statements to the code in
smp_call_function_single of smp.c. When csd_stack is declared as
"struct ____cacheline_aligned_in_smp __call_single_data csd_stack",
this first case is the case where the code works:

unloading the scsi module:
--------------------------------------------------
smp:
&csd_stack.info=fffffc000493fd90
&csd=fffffc000493fd98
smp:
&csd_stack.info=fffffc000493fd90
&csd=fffffc000493fd98
sd 6:0:1:0: [sdb] Synchronizing SCSI cache
rcu: rcu_barrier: cpu=0
smp:
&csd_stack.info=fffffc000935bc50
&csd=fffffc000935bc58
rcu: rcu_barrier: cpu=1
smp:
&csd_stack.info=fffffc000935bc50
&csd=fffffc000935bc58
rcu: rcu_barrier: cpu=2
smp:
&csd_stack.info=fffffc000935bc50
&csd=fffffc000935bc58
smp: generic_exec_single: csd=fffffc000935bc38 cpu=2 smp_cpu=2



Below is the same debug output when csd_stack is declared as
"call_single_data_t csd_stack" (i.e. no patch applied). For some
reason, in this case, the address of the csd variable is the same as
the address of csd_stack.info. If this is really the case, no wonder
that a write to csd_stack.info will overwrite the csd pointer. In this
case the code fails according to below:

unloading the scsi module:
-----------------------------------------
smp:
&csd_stack.info=fffffc000493fd98
&csd=fffffc000493fd98
smp: smp_call_function_single: not wait smp_cpu=1
sd 6:0:1:0: [sdb] Synchronizing SCSI cache
rcu: rcu_barrier: cpu=0
smp:
&csd_stack.info=fffffc0006207c58
&csd=fffffc0006207c58
smp: generic_exec_single: csd=fffffc0006207c40 cpu=0 smp_cpu=0
Unable to handle kernel paging request at virtual address 0000000000000008
CPU 0
rmmod(1443): Oops 0
pc = [<fffffc00003dd564>]  ra = [<fffffc00003dd558>]  ps = 0000    Not tainted
pc is at smp_call_function_single+0x204/0x220
ra is at smp_call_function_single+0x1f8/0x220




Below is yet another test, here the code works, csd_stack is declared
as "call_single_data_t csd_stack" (i.e. no patch applied). In this
example the code works since I've added some extra "dummy variables"
on the stack which seems to steer things around enough. Here it's also
clear that the address of csd does not overlap with the address of
csd_stack.info. test0 and test1 are just the extra local variables
that I've added.

-----------------------------------------
smp:
&csd_stack.info=fffffc000493fd78
&csd=fffffc000493fd90
smp: smp_call_function_single: not wait smp_cpu=1
smp: &test0=fffffc000493fd98
smp: &test1=fffffc000493fd88
sd 6:0:1:0: [sdb] Synchronizing SCSI cache
rcu: rcu_barrier: cpu=0
smp:
&csd_stack.info=fffffc0009e07c38
&csd=fffffc0009e07c50
smp: &test0=fffffc0009e07c58
smp: &test1=fffffc0009e07c48
smp: generic_exec_single: csd=fffffc0009e07c20 cpu=0 smp_cpu=0




Patch I used to "fix" kernel/smp.c
----------------------------------------------------
+++ kernel/smp.c        2024-12-19 19:01:20.592819628 +0100
@@ -631,7 +631,7 @@
int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
                             int wait)
 {
        call_single_data_t *csd;
-       call_single_data_t csd_stack = {
+       struct ____cacheline_aligned_in_smp __call_single_data csd_stack = {
                .node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
        };
        int this_cpu;



/Magnus
