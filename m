Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552A1BF7E0;
	Sun, 12 Jan 2025 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736724373; cv=none; b=ibwbLhUAxtTTnk3d8vE97MRtL6v1xIO8bx3Kzp+HZiyQ8fx3OgrTX2cn4zPC5GgrjiJJNj/vweKLkT3MoDbAfd97NnBAKbIfheB70UJNzFSdSYsA+qKcHkxedFQMsQmUH57J54+9EX1D8Cw1UqxrUr0PNfhEepgY9Vcr3bX+ZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736724373; c=relaxed/simple;
	bh=PvKrhZJMg32VCPn9ZWHLXRN/UyM4fxxhV2AZssF+TZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw4EkrjACpvp+u05vofajatAMqMqJ0XFXIbXwfP35LSRy35KvMl1Uas/TP5R8mScdQiZr48ypFDKkjrqe5DlyIAAme4DA9Y9B7cWA/oGUATY8mrPpeKG4m+VOeQH7aqragpfQ5p0JbLkwvVkoyomQeHaWR0vY0BXyn3zW47VBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpaYGEE5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpaYGEE5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso4821000a12.0;
        Sun, 12 Jan 2025 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736724370; x=1737329170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnWgqywIVuHL3v0PYcULOABULUOK7rc2D6wwz4OSIpk=;
        b=dpaYGEE5zed0VGwEsz5085ZJ2IiEUqevAKq3Qtk/ltX1XRhpFDaCPxOtB3ZvdoFPKK
         w4GkJXlTuI8G+O1UUvs89EXSCvOPgy6FqZ4VEyswHTTW0/g9GgNEzcA/IX2WT+5YiDDR
         uFWJcwMMX+kAEzhU/fxDoabPGSzYfN5arV09z2b53548Aq67ZfuQQ/KMJoEMSDnHnN7y
         QB9NbjN47LXoWbTCxpbsoTnGsOrGH33s7NsF9SX/vjG4HSWJHFnKb6VwfBoBFAjzu/xT
         zX51p+zEF48kOgRpfOoRUykndE+B4SUB4knnZ1k1VrceYVPNwK4qpBYBQkStHtsw5rcz
         2XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736724370; x=1737329170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnWgqywIVuHL3v0PYcULOABULUOK7rc2D6wwz4OSIpk=;
        b=KMPC23rpJ/cqq3J3YZSqmUY6DqkRdlPFTkJuXETYm0qPPNb6D3iPboikpCeJZgUBhN
         J8MbWtiZ4KtxbcqusPuQpcIxxbX7yZhGtyYcMfAIyAENTqZRBuGuaIZZQ9RyvgkTeRCI
         uKP71CYn/X3PLXXPfOd2A/UDthbRaZqSGor7uHFwZVGnErm6WFicZBuTwI1H2fNGrD5d
         SQfR8kEoHZFJ+CIGHj/QVv27TzCMB1i5VxVkMUVLsD23iW5ct2Owaq4JiViIQ8FKUIPm
         gawLR5iicAL49fKqn6UGewKmiWTILe3KxuG5zHj+aQqhzlhSD4+B+mAL9G96rSHZl19B
         DMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi1whZ70rL4cGLjScbAx6V7pef0WAaNNqY1ahieZzg0Dtxmk7wJCLvYRyv2c5uoRcjV+hB@vger.kernel.org, AJvYcCWyvdUE7wOnDidzyFURAEZKq46Qoa2oDQlKNcAU0E6L9ruCtun2arssU9Bm/xtrZTMQpMuX8px0PRaMvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UtjSJvM4/FMv/2S5kRmfJIps2OJnwRZrpFT+6LagcnxbMipy
	5dchsRg7Hs4EBstaI/6jlPE0iKqLqjXaJQ7qOKKabIk3gh5FM+gbjbcyChy2NF6PmHEiqdMDVU6
	xW3UkSss8F6YfYwj8AsX/B9HXGTVNO+sW
X-Gm-Gg: ASbGncsO4p9F9tSEj6HgvG7NWng/gp9F+C28MZER1xokLrNk/XSIoGs828iqhvLnc6W
	bKKYmjyxTmnL/fZibpQH3oTsm32MzW2R/M52hHDI=
X-Google-Smtp-Source: AGHT+IF4crZ4BXYJg7zPrUUZbYQzjy/fTeEWGDQcJYqwlBc9i/cFmey0IAdVs9T1ay9Zd4tATDrRomo1DqGglXaiiik=
X-Received: by 2002:a17:906:f59f:b0:aa6:8781:9909 with SMTP id
 a640c23a62f3a-ab2ab709f7bmr1675045166b.29.1736724369734; Sun, 12 Jan 2025
 15:26:09 -0800 (PST)
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
 <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
In-Reply-To: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 13 Jan 2025 00:25:58 +0100
X-Gm-Features: AbW1kvYAG26LRO9EMlFLZEj1BlQ0YkQEctUkXvVHlLeaqahOMfKC294a8U_E2zk
Message-ID: <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again.

I've been running some more tests, this time with a smp kernel but on
a system with just one cpu, seems to me as a bit simpler scenario to
analyze. I've added some print statements to smp_call_function_single,
just to see what's really going on:

pr_warn("smp_call_function_single: %llx %llx
size=3D%d\n",&csd_stack,&csd, sizeof(call_single_data_t));

output is seen below:
smp: smp_call_function_single: fffffc000493fc40 fffffc000493fc58 size=3D32
so, the csd_stack struct is 32-bytes in size but &csd - &csd_stack =3D
24. This does not make any sense?


pr_warn("\n&csd_stack.info=3D%lx\n&csd=3D%lx\n",&csd_stack.info,&csd);

output according to below:
smp:
&csd_stack.info=3Dfffffc000493fc58
&csd=3Dfffffc000493fc58

Here csd variable has the same address on the stack as csd_stack.info.

Using above information and locking at the disassembly of
smp_call_function_single in smp.o I've put together the following
table mapping out the stack of smp_call_function_single:


$sp+0 ra
$sp+8 s0
$sp+16
$sp+24
$sp+32 csd_stack.node 0xfffffc000493fc40
$sp+40 csd_stack.node 0xfffffc000493fc48
$sp+48 csd_stack.func 0xfffffc000493fc50
$sp+56 csd_stack.info 0xfffffc000493fc58
$sp+64 csd 0xfffffc000493fc58
$sp+72
$sp+80 a3
$sp+88 a2
$sp+96 a0
$sp+104 a1
$sp+112 -


When requesting csd_stack to be aligned using
__attribute__((__aligned__(x))) it seems as if the compiler does not
leave enough room above the csd_stack struct. i.e since the exact
location of csd_stack depends on the actual value of $sp it is not
known at compile time. Seems like gcc does not take this into account.
The code works fine if I remove the alignment attribute for csd_stack.
Also as previously mentioned, declaring csd_stack as "struct
____cacheline_aligned_in_smp" makes it work, but judging from the
disassembly code, this statement has no effect on the alignment of
csd_stack, i.e csd_stack is not aligned to anything its simply just
placed on the stack, indirectly making it just 16-byte aligned instead
of the requested 32-byte alignment.

It seems to me that, when used to align variables that reside on the
stack,  __attribute__((__aligned__(x))) does not work correctly with
gcc/alpha/linux.


/Magnus

On Tue, Dec 31, 2024 at 11:43=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com=
> wrote:
>
> >  Umm, no.  The psABI guarantees 16-byte alignment for the stack pointer=
,
> > and under this condition (((x - 17) & ~31) + 32 <=3D x) is guaranteed t=
o be
> > true (except for the overflow case, of course, which does not apply her=
e).
>
> aha! that explains it! thanks, is the psABI available somewhere?
>
> >
> >  Would you be able to trace it back further, e.g. by adding BUG_ON(!nod=
e)
> > to `__smp_call_single_queue' and so on if required, to see where this N=
ULL
> > pointer comes from originally?  I do hope such a minimal probe won't
> > disturb code generation enough for this to become a heisenbug.
> >
> Hi, below are some additional test that I've made,
>
> It seems to me that part of the stack is overwritten with the values
> of other local variables. Previously this affected the return address
> on the stack causing kernels Oops on function return (see previous
> mail in thread). In this run it seems like when the pointer *csd in
> smp_call_function_single is stored on the stack, it gets overwritten
> by writes to csd_stack.info. The difference here is that I use GCC
> 15.0.0 20241225 (experimental) instead of gcc (Gentoo 14.2.1_p20241116
> p3) 14.2.1. To me, this looks like the same problem but the clobbering
> just hits a different part of the stack. Below is some debug-output,
> where I've added some print statements to the code in
> smp_call_function_single of smp.c. When csd_stack is declared as
> "struct ____cacheline_aligned_in_smp __call_single_data csd_stack",
> this first case is the case where the code works:
>
> unloading the scsi module:
> --------------------------------------------------
> smp:
> &csd_stack.info=3Dfffffc000493fd90
> &csd=3Dfffffc000493fd98
> smp:
> &csd_stack.info=3Dfffffc000493fd90
> &csd=3Dfffffc000493fd98
> sd 6:0:1:0: [sdb] Synchronizing SCSI cache
> rcu: rcu_barrier: cpu=3D0
> smp:
> &csd_stack.info=3Dfffffc000935bc50
> &csd=3Dfffffc000935bc58
> rcu: rcu_barrier: cpu=3D1
> smp:
> &csd_stack.info=3Dfffffc000935bc50
> &csd=3Dfffffc000935bc58
> rcu: rcu_barrier: cpu=3D2
> smp:
> &csd_stack.info=3Dfffffc000935bc50
> &csd=3Dfffffc000935bc58
> smp: generic_exec_single: csd=3Dfffffc000935bc38 cpu=3D2 smp_cpu=3D2
>
>
>
> Below is the same debug output when csd_stack is declared as
> "call_single_data_t csd_stack" (i.e. no patch applied). For some
> reason, in this case, the address of the csd variable is the same as
> the address of csd_stack.info. If this is really the case, no wonder
> that a write to csd_stack.info will overwrite the csd pointer. In this
> case the code fails according to below:
>
> unloading the scsi module:
> -----------------------------------------
> smp:
> &csd_stack.info=3Dfffffc000493fd98
> &csd=3Dfffffc000493fd98
> smp: smp_call_function_single: not wait smp_cpu=3D1
> sd 6:0:1:0: [sdb] Synchronizing SCSI cache
> rcu: rcu_barrier: cpu=3D0
> smp:
> &csd_stack.info=3Dfffffc0006207c58
> &csd=3Dfffffc0006207c58
> smp: generic_exec_single: csd=3Dfffffc0006207c40 cpu=3D0 smp_cpu=3D0
> Unable to handle kernel paging request at virtual address 000000000000000=
8
> CPU 0
> rmmod(1443): Oops 0
> pc =3D [<fffffc00003dd564>]  ra =3D [<fffffc00003dd558>]  ps =3D 0000    =
Not tainted
> pc is at smp_call_function_single+0x204/0x220
> ra is at smp_call_function_single+0x1f8/0x220
>
>
>
>
> Below is yet another test, here the code works, csd_stack is declared
> as "call_single_data_t csd_stack" (i.e. no patch applied). In this
> example the code works since I've added some extra "dummy variables"
> on the stack which seems to steer things around enough. Here it's also
> clear that the address of csd does not overlap with the address of
> csd_stack.info. test0 and test1 are just the extra local variables
> that I've added.
>
> -----------------------------------------
> smp:
> &csd_stack.info=3Dfffffc000493fd78
> &csd=3Dfffffc000493fd90
> smp: smp_call_function_single: not wait smp_cpu=3D1
> smp: &test0=3Dfffffc000493fd98
> smp: &test1=3Dfffffc000493fd88
> sd 6:0:1:0: [sdb] Synchronizing SCSI cache
> rcu: rcu_barrier: cpu=3D0
> smp:
> &csd_stack.info=3Dfffffc0009e07c38
> &csd=3Dfffffc0009e07c50
> smp: &test0=3Dfffffc0009e07c58
> smp: &test1=3Dfffffc0009e07c48
> smp: generic_exec_single: csd=3Dfffffc0009e07c20 cpu=3D0 smp_cpu=3D0
>
>
>
>
> Patch I used to "fix" kernel/smp.c
> ----------------------------------------------------
> +++ kernel/smp.c        2024-12-19 19:01:20.592819628 +0100
> @@ -631,7 +631,7 @@
> int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>                              int wait)
>  {
>         call_single_data_t *csd;
> -       call_single_data_t csd_stack =3D {
> +       struct ____cacheline_aligned_in_smp __call_single_data csd_stack =
=3D {
>                 .node =3D { .u_flags =3D CSD_FLAG_LOCK | CSD_TYPE_SYNC, }=
,
>         };
>         int this_cpu;
>
>
>
> /Magnus
