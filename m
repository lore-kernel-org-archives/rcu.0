Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84F1F1310;
	Fri, 27 Dec 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296184; cv=none; b=cQrpnxif87NhEWYi5uRFGxwt9+RSq7+kyp939ht2+7q/ys+GuHUrLWX76H6Ql2Dsd/6FE396nc6T6pqQmuIPBgKUE+AvnB5J71pmQlBPVHvmn2BswRptkQ5xyFT3+N9Eg/kF4V7TnRkXgtKglROOJ6OfzXtODsxQ/oHYnG0NhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296184; c=relaxed/simple;
	bh=siQbiKFwr2CpGKl7Go74NpbnuSEyZX1ge05n4xnPrSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6UvMXTjk3KRJ9O/Ogaejr0UvU1t0A+rMYvZdqoPYaf7/AO0O/vgevAnTLkHfyG7fAN7O9gOKzQS5/UKLqZwYErEYrgGzqEE953RoEHm41GbDOeHJS73aay02b6l2V2cjBfKtEg8qXTfa62t5Y+SNQvcewHIiebNRoRD6oDLk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXO+GGnN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXO+GGnN"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso3328910a12.0;
        Fri, 27 Dec 2024 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735296181; x=1735900981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0732FTT2bfW2JoIsn/wOq5+IdXAcmZ9lcahoNJojnnc=;
        b=ZXO+GGnN+6gR4z8XLOHDOSWngzlf9drdUD4Mgmwf9EOPRZGOEKV5QlOmw0L8KrdZ1d
         hQrZsgSSNaa7OlI2IdqjkyxExUsK7IMxmFvbVukCUT8QXGhB1zPFfWimCMLnpqiPbgzr
         tz21jF12ZAKTM1XxWG6FUUNu2pz0mVFqgHlMbBQsX+mwANbP4Jf8c0urY8h9ude8lNY7
         S8BWm4hZ4yVGi+JsCwO/d7Lx4UGS+mrbvZEpWLOhTkOZUrOS4Y042FfJ0XiVuO2mh9DO
         0FtUlW/+VG6CKQ7rrRXGYv82sEDvFXFVAMUTX2MBBIJr055MoeP7aHKAtKMOsc45uk6H
         7aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735296181; x=1735900981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0732FTT2bfW2JoIsn/wOq5+IdXAcmZ9lcahoNJojnnc=;
        b=E43W1wDtDSx3APtiIvbb37ARQsH6Z5Lv5fgBqaiafUTYmtqXB3l2VfmK3IvN1hYO1V
         JZso3qbAF+VpjFLqEE5AznLPQzGOlwkyNfas+iZJ6iFlUBKXc0gPTye77pahd/nkXqx2
         s67tw6An7BcC5dK7cC8K1Ie+BRpHnOzUdDC6jPKvrFSnW88kRyXS4uHUXY5bzOizjyP4
         a8JpknS8UnYHWRoQYMZSnt2M5MQUA//ckwDrem0GrE6U2l0JUftLaHDg7QegcyR1Fz/N
         mMNk6Ufi44k4f+IBsa2uzWo7Qh6zgQEwxKI9ReJ8mXOriRU7monUtXduCNqAGkIopZ0l
         Vwbg==
X-Forwarded-Encrypted: i=1; AJvYcCVWM84TSFUFTp6oTAFPnp7SYi1CV1uVKhZq1lk2x0folD67PzLMutAjaP22HFvlaVzsTPRW@vger.kernel.org, AJvYcCXZkrGW2fwvRy4DfowYQuvkXBi1A3F83hiFYsPajMyRG+NO7gIAWwSjqrgROQLbzTx2bADLJFEZJQmoDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaItVu0KvrcqlParYl0F8nhVx1IcKgQ2Xt864F2phX8w9kZvU
	IqJt7+7XPct97FXp5fNcfe4GqYEru89ld6ZpkBoELf+N6BUY5JB//q6BbdAdwfDRbLopDPSqEnc
	7jq/qpNZy1r6wSzhqgkK+klo+6wJ7mpDY
X-Gm-Gg: ASbGnctVzpiSbgdd1wYdrtXmUJaTB2rP+94Ww8nQyFuGJ9yf3fPWZ+OfO3Khzji7PbH
	j9SrxL07v+SIj2KGNOx4PzSMtYavsk3I1uqv7ce8=
X-Google-Smtp-Source: AGHT+IH+IoYZOwkreNczRFLhT3TTIaVrMsWyDzGMSlN/equuTZPuL6K6jrpOEFpMCvuy+jXgli6URp7/oVkiJ/RNt7s=
X-Received: by 2002:a05:6402:3507:b0:5d1:fb79:c1b2 with SMTP id
 4fb4d7f45d1cf-5d81dd7f7f8mr22691543a12.11.1735296180468; Fri, 27 Dec 2024
 02:43:00 -0800 (PST)
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
In-Reply-To: <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 27 Dec 2024 11:42:49 +0100
Message-ID: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The best thing would of course be to fix the compiler.  If that cannot
> > be done, why not just carry these patches?
>
>  Right.  Magnus, has your kernel been built with compiler options implying
> BWX support?  If not, can you please rebuild it accordingly and see if it
> changes anything?
>
>  Also a data race between RMW accesses can't be ruled out even with BWX
> Alphas, because GCC insists on producing those sequences, as I discovered
> in the course of implementing said GCC fix for data safety[1].  For BWX
> use it should be ready to build a working kernel right away, because no
> unaligned LL/SC emulation is required, so Magnus, can you please try the
> patchset out in the second step and see if it makes any change?
>
>  Of course it might break things horribly too, as I still haven't got to
> verifying the BWX side beyond the assembly pattern match snippets in the
> GCC testsuite (to be done hopefully in the next couple of weeks).

Hi,

I've done some more testing last couple of days and it seems like
applying the one-liner "fix" to smp.c (alignment of csd_stack in
function smp_call_function_single) is sufficient to mitigate both rcu
related bugs (the bugs are not even rcu related). I guess it's pretty
simple to just carry this patch until we figure out the root cause.
Either way, I've tried to get a better understanding of what gcc is
doing differently in the two cases:

1)
The code generated by gcc from smp.c reserves 96 bytes of stack space
but places csd_stack struct on $sp+79. Since sizeof csd_stack is 32
bytes, it seems to me that [($sp+79) & NOT(0x1f) +
sizeof(call_single_data_t)] might be greater than "96+$sp" if say, bit
3 and 4 are set in $sp? or am I missing something here?

---------------------------
lda     sp,-96(sp)
...
lda     s0,79(sp)
...
andnot  s0,0x1f,s0
...
stq zero,8(s0)
stq zero,0(s0)
stq     zero,16(s0)
stq     zero,24(s0)
stl     t0,8(s0) [.node =  CSD_FLAG_LOCK | CSD_TYPE_SYNC]



2)
Using  cacheline_aligned_in_smp when declaring csd_stack in
smp_call_function_single will actually reserve less stack space (80
bytes in stead of 96), csd_stack is referenced directly using $sp.
Maybe alignment is just a way to simplify things for gcc and avoid
hitting compiler bugs?
--------------------------
lda     sp,-80(sp)
stq     zero,48(sp)
stq     zero,64(sp)
stq     zero,72(sp)
stl     t0,56(sp) [.node =  CSD_FLAG_LOCK | CSD_TYPE_SYNC]




I've made numerous attempts with different versions of GCC, including
the most recent git version (with and without the patches from Maciej)
and they give similar results, even though the exact amount of
stackspace reserved, registers used, and placement of csd_stack struct
will differ somewhat. (GCC) 15.0.0 20241225, with Maciej patches
applied, will produce the code below:

lda     sp,-112(sp)
lda     t1,47(sp)
andnot  t1,0x1f,t1
...

Which boots and lets me load/unload my scsi kernel moduel, but just
adding some debug print statement to smp_call_function_single will
again give a kernel null pointer exception. Printing the value of &csd
seems to allocate space for csd on the stack instead of keeping it in
registers which will later trigger a null pointer excepting when
accessed. To me it seems like this just moves around the stack
clobbering problem?



CPU 1
rmmod(1444): Oops 1
pc = [<fffffc000078e818>]  ra = [<fffffc00003dd0f8>]  ps = 0000    Not tainted
pc is at llist_add_batch+0x8/0x50
ra is at __smp_call_single_queue+0x38/0xa0
v0 = 0000000000000000  t0 = fffffc0000e2b100  t1 = fffffc0000ec4048
t2 = 0000000000000000  t3 = fffffc0000ec4048  t4 = 0000000000000000
t5 = 0000000000000001  t6 = ffffffffffffffec  t7 = fffffc0005d4c000
s0 = 0000000000000000  s1 = 0000000000000001  s2 = 0000000000000001
s3 = 0000000000000001  s4 = fffffc0000cd0330  s5 = fffffc000020ee80
s6 = 00000200010422a0
a0 = 0000000000000000  a1 = 0000000000000000  a2 = fffffc000020f100
a3 = fffffc0005d4fa28  a4 = ffff1020ffffff00  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000001  t10= 0000000000000000
t11= 0000000000000000  pv = fffffc000078e810  at = 0000000000000000
gp = fffffc0000e9c980  sp = 00000000905861a6
Disabling lock debugging due to kernel taint
Trace:
[<fffffc00003dd1bc>] generic_exec_single+0x5c/0x150
[<fffffc00003dd3ec>] smp_call_function_single+0x13c/0x220
[<fffffc000082ceec>] device_release+0x3c/0xf0
[<fffffc00003ae178>] rcu_barrier+0x1b8/0x4d0
[<fffffc00003aaa30>] rcu_barrier_handler+0x0/0x120
[<fffffc00003aaa30>] rcu_barrier_handler+0x0/0x120
[<fffffc0000858418>] scsi_host_dev_release+0x58/0x170
[<fffffc000082cf04>] device_release+0x54/0xf0
[<fffffc0000b501f0>] kobject_put+0x90/0x1b0
[<fffffc000082d0fc>] put_device+0x1c/0x30
[<fffffc00008583ac>] scsi_host_put+0x1c/0x30
[<fffffc00007b9694>] pci_device_remove+0x34/0x90
[<fffffc0000838284>] device_remove+0x64/0xb0
[<fffffc0000839d24>] device_release_driver_internal+0x284/0x370
[<fffffc0000839ecc>] driver_detach+0x7c/0x110
[<fffffc00008377e8>] bus_remove_driver+0x98/0x160
[<fffffc000083a754>] driver_unregister+0x44/0xa0
[<fffffc00007b94e8>] pci_unregister_driver+0x38/0xd0
[<fffffc00003be264>] sys_delete_module+0x174/0x2f0
[<fffffc000031095c>] entMM+0x9c/0xc0
[<fffffc0000310d04>] entSys+0xa4/0xc0
[<fffffc0000310d04>] entSys+0xa4/0xc0

Code:
  f43ffffb
  6bfa8001
  47ff041f
  2ffe0000
  a4120000  <---  ldq     v0,0(a2) (*first = READ_ONCE(head->first);)
  60004000  <---  mb
 <b4110000> <---  stq     v0,0(a1) (new_last->next = first;)
  60004000
