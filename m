Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9618E056;
	Wed,  4 Dec 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350938; cv=none; b=mF+DTWogxbFrtyAfEI9ZUpdN82xw8ivzJMdEecZLKtZ0eAv+TAdGicBpfVp+isHpc2q+HkbkVF3krT00SoxU8U/lbDfdxSoJPBF+md7cFdk7E6UFJpd2ZPyxr7sLGKbMxFtrpORA45gtRisu/f4DmG+1ANjk8Pz3hHxkhHPmGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350938; c=relaxed/simple;
	bh=GXAivyX3BLDJbQhR20QVD5brbpPwgqai1X9fU1HiAAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNRLEG+uk0fP2LGusb+I6Krmv9IG4Y4Id3jeyhB8SC81+0nwZVOGe5hBxfhP//93rRfRhBut4ogt1wkah7xaOXNj8kRUckZcF2d6D04z9QscbcGXK7Rb1+Ol7vI7yREeag1CtV15Y5H1Utj7Vbf+omzM1e3cfHHVdV8UfBHcOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/cSdILy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/cSdILy"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa52edbcb63so245362266b.1;
        Wed, 04 Dec 2024 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733350935; x=1733955735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk2GsqQIWANJ4oI4tJzfja7xzIBstCmJ1kQvyGyhlYw=;
        b=i/cSdILynfdvREuqngQjcxtxURpxKlVf2uVDIzvRbuS5IhoFHL2N61YOQkm9RWVzYm
         6ZRr+3FZdc0uKgu5aiyS8SqIgXsQj8fz2MFXG4poW3G/cPe40SiT3FlXRQBjyzR7ZswD
         OCaMM1kIh2VOfKx77xuoazHbjZ+3NW87Ln4MfkbFxYxpCigkSC0t6cA0g+12SFMJlUC1
         exS35Pw8vja97L9QbniMDhwEfyo2PWXzFeLYmnRy3ROq45H45+42MJqP4LnXFQoRTQEc
         oI3sBW14VwOnuUMmFl6/ACbVXQ8VPxb889b82qel/zJJM48G80Bry/ZJ7HH+VRGHYHPh
         hblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350935; x=1733955735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk2GsqQIWANJ4oI4tJzfja7xzIBstCmJ1kQvyGyhlYw=;
        b=WrwEAKsjpSvIQnRdArbnbEv+tIK02uLE2kw4Q9sLst4Od1H6nXQL1hAO5wyR82EI+/
         KqH0XI96B61XQplinCSMXR3rbQjqSVv8tRTFYtiCJhLS6JEKMJLtISUr5WD4BBFn5JlZ
         WD795SNSllvJiJzBeNnL+2rzzOYnLSIMcLb+cTlZ0v1VJDWmgpe8pfawM1aCPLqGQXG3
         cqt2YFzvCQ7LaWD3OBaN06i51L6+w2OE4023xJqBSMXdXauAF229O3A5e18CBGIa0MNc
         DTVl/8nrQuz5sXd3Vugg01PMZYjsQcjo8j96qxllJRx4cYVCjxrIvfR6EBV4+O4rHr3u
         SPmA==
X-Forwarded-Encrypted: i=1; AJvYcCXGC3W81uiHK6Uj1QH1hn4riaGH6Pm8gDb649c6vCOlS3qE6kgEmXDWhkXA/uOHHQgQQgOZYbbo73UKDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQi1hg8R28d8peQxXc5XHrnv49jjDFT9jo3kk206MomrcNcjEY
	8+guWvdh6SK6z98jLrmvOGAnUEKcu7zFMDcKKC5+03lhWQ0Tg/NGxM1rwTD+ReYUdu2XQRgMRTS
	ssp3UQGEna4+59R32J4a+/SRpmnKlbdXb
X-Gm-Gg: ASbGncszQOZJ2ilCmotmVVyl1Kvtxdk8etBZVHT2/2nGFb09fPzLpXd8kTsTBjel1lE
	AopD/YgacHzfEAf+YPLSIPRmyRH8vYBtZ
X-Google-Smtp-Source: AGHT+IHjwXmgs478IvSp+mFpVdVQaPiJJXpxIzS9sQ10IYMRWoz3ItW6P/mN4LzsK4BzcQLfG85EOC09jwVufAh8BJk=
X-Received: by 2002:a17:906:59a0:b0:aa6:18b6:3113 with SMTP id
 a640c23a62f3a-aa6219f1211mr100110666b.31.1733350934694; Wed, 04 Dec 2024
 14:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
In-Reply-To: <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Dec 2024 23:22:03 +0100
Message-ID: <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've been looking a bit closer at the RCU problem on Alpha, in the
case with the bug
related to interface-renaming after the changes in the networking code
the code fails
with an invalid pointer reference. From the stack trace one can
conclude that this
happens when using synchronize_rcu_expedited() in stead of
synchronize_rcu_normal().
The use of rcu_normal can be enforced by setting kernel parameter
rcupdate.rcu_normal=3D1
at boot. This makes recent kernels boot again on my Alphas, a simple enough
workaround for now.

The code fails inside work-queue handler wait_rcu_exp_gp() when its
trying to call
rcu_exp_sel_wait_wake(). looking at the code generated from the
compiler the call
to rcu_exp_sel_wait_wake() appears to be inline-optimized, so no
actual call to this
function. If I add some bogus-code (i.e a print call that references
the address of a
local variable, something that the compiler can't optimize away)
before the call to
rcu_exp_sel_wait_wake(), the code works! The same effect is achieved
by declaring
the local variable as volatile.

I've also noted a similar behavior in the scsi driver code, where
unloading of a scsi
driver kernel module (in my case qla1280) will trigger a kernel Oops. As in=
 the
example above, this can be mitigated by adding a reference to local variabl=
es.
When doing "rmmod qla1280" scsi_host_dev_release() calls rcu_barrier(). In =
this
function call I noticed that the stack was somehow corrupted and the
return address
to scsi_host_dev_release() was overwritten. The stack corruption occurs in =
the
"for_each_possible_cpu(cpu)" loop inside rcu_barrier(). Below are stack dum=
ps
from before/after the for_each_possible_cpu loop. The call to
scsi_host_dev_release
disappears in stack trace since its return address (fffffc0000b6a3ec)
is replaced
by a '1' and at the of the call to rcu_barrier(). We get a kernel Oops
since the $ra=3D1 is used as return address.

In both RCU cases above, stack corruption occurs and the sections that caus=
e
problems involve the use of kernel threads so concurrency might be an
issue here.
Since the RCU code works on other platforms and can be "fixed" on Alpha as =
well
just by declaring certain variables as volatile (or by other means
making sure that
they are not optimized away from the code) can this be a compiler issue on
alpha or is it the result of not taking proper measures, in the code,
to account for the
weak memory model on Alpha? Or a combination of the two?


/Magnus Lindholm


Stack traces showing the corrupted stack frames:
----------------------------------------------------------------

rcu: inside rcu_barrier 5
CPU: 1 UID: 0 PID: 1430 Comm: rmmod Not tainted 6.12.1-gentoo #43
        fffffc000987fc88 fffffc0000e66440 fffffc00003a8bc8 0000000000000000
        fffffc0000e667b0 fffffc000480b5d8 fffffc0000b6a3ec fffffc0004a2a000
        fffffc0004a2a240 fffffc000480b5d8 0000000000000000 fffffffc00502068
        0000020001043480 00000200010422a0 0000000000000000 0000000000000000
        fffffc0000b68efc fffffc0004a2a240 fffffc0006319300 0000000000000000
        fffffc0000b2ed80 fffffc0004a2a240 fffffc0000b9d278 0000000000000000
 Trace:
 [<fffffc00003a8bc8>] rcu_barrier+0x1f8/0x580
 [<fffffc0000b6a3ec>] scsi_host_dev_release+0xac/0x1cc
 [<fffffc0000b68efc>] device_release+0x148/0x218
 [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
 [<fffffc00007cac3c>] put_device+0x1c/0x30
 [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
 [<fffffc00007554a4>] pci_device_remove+0x34/0x90
 [<fffffc00007d5c04>] device_remove+0x64/0xb0
 [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
 [<fffffc00007d783c>] driver_detach+0x7c/0x110
 [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
 [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
 [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
 [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
 [<fffffc0000310d34>] entSys+0xa4/0xc0


rcu: inside rcu_barrier 6
CPU: 1 UID: 0 PID: 1430 Comm: rmmod Not tainted 6.12.1-gentoo #43
        fffffc000987fc88 fffffc0000e66440 fffffc00003a8c44 0000000000000002
        fffffc0000e667b0 fffffc0000e44240 0000000000000001 fffffc0004a2a000
        fffffc0004a2a240 fffffc000480b5d8 0000000000000000 fffffffc00502068
        0000020001043480 00000200010422a0 0000000000000000 0000000000000000
        fffffc0000b68efc fffffc0004a2a240 fffffc0006319300 0000000000000000
        fffffc0000b2ed80 fffffc0004a2a240 fffffc0000b9d278 0000000000000000
 Trace:
 [<fffffc00003a8c44>] rcu_barrier+0x274/0x580
 [<fffffc0000b68efc>] device_release+0x148/0x218
 [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
 [<fffffc00007cac3c>] put_device+0x1c/0x30
 [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
 [<fffffc00007554a4>] pci_device_remove+0x34/0x90
 [<fffffc00007d5c04>] device_remove+0x64/0xb0
 [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
 [<fffffc00007d783c>] driver_detach+0x7c/0x110
 [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
 [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
 [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
 [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
 [<fffffc0000310d34>] entSys+0xa4/0xc0


Unable to handle kernel paging request at virtual address 0000000000000000
CPU 1
rmmod(1430): Oops -1
 pc =3D [<0000000000000000>]  ra =3D [<0000000000000001>]  ps =3D 0000    N=
ot tainted
 pc is at 0x0
 ra is at 0x1
 v0 =3D 0000000000000007  t0 =3D fffffc0000ec7aa8  t1 =3D ffffffffffffffff
 t2 =3D fffffc0000e65df0  t3 =3D 00000000000026f0  t4 =3D 00000000000028f1
 t5 =3D 00000000000c2e20  t6 =3D 00000000000c2e68  t7 =3D fffffc000987c000
 s0 =3D fffffc0004a2a000  s1 =3D fffffc0004a2a240  s2 =3D fffffc000480b5d8
 s3 =3D 0000000000000000  s4 =3D fffffffc00502068  s5 =3D 0000020001043480
 s6 =3D 00000200010422a0
 a0 =3D 0000000000000000  a1 =3D 0000000000000001  a2 =3D 00000000000028f0
 a3 =3D fffffc000987fa38  a4 =3D 0000000000000000  a5 =3D 0000000000000000
 t8 =3D 00000000000c2e20  t9 =3D ffffffffffffffec  t10=3D 0000000000000001
 t11=3D 00000001000024f0  pv =3D fffffc000038a1f0  at =3D 0000000000000000
 gp =3D fffffc0000eb7aa8  sp =3D 00000000183e6a07
 Disabling lock debugging due to kernel taint
 Trace:
 [<fffffc0000b68efc>] device_release+0x148/0x218
 [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
 [<fffffc00007cac3c>] put_device+0x1c/0x30
 [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
 [<fffffc00007554a4>] pci_device_remove+0x34/0x90
 [<fffffc00007d5c04>] device_remove+0x64/0xb0
 [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
 [<fffffc00007d783c>] driver_detach+0x7c/0x110
 [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
 [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
 [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
 [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
 [<fffffc0000310d34>] entSys+0xa4/0xc0


Below are the changes I made to the kernel source in order mitigate
the stack corruption problem
this is not really a fix but it can be of use to gain further
knowledge on whats really going on:
---------------------------------------------------------------------------=
---------


diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..8241313404f7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4553,7 +4553,7 @@ static void rcu_barrier_handler(void *cpu_in)
  */
 void rcu_barrier(void)
 {
-       uintptr_t cpu;
+       volatile uintptr_t cpu;
        unsigned long flags;
        unsigned long gseq;
        struct rcu_data *rdp;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fb664d3a01c9..afba0ebc80e4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -477,7 +477,7 @@ static inline void
sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
  */
 static void wait_rcu_exp_gp(struct kthread_work *wp)
 {
-       struct rcu_exp_work *rewp;
+       volatile struct rcu_exp_work *rewp;

        rewp =3D container_of(wp, struct rcu_exp_work, rew_work);
        rcu_exp_sel_wait_wake(rewp->rew_s);
@@ -705,6 +705,7 @@ static void rcu_exp_wait_wake(unsigned long s)
  */
 static void rcu_exp_sel_wait_wake(unsigned long s)
 {
+       pr_warn("inside rcu_exp_sel_wait_wake, %llx\n",(void*)s);
        /* Initialize the rcu_node tree in preparation for the wait. */
        sync_rcu_exp_select_cpus();






On Sun, Dec 1, 2024 at 6:04=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Sun, Dec 01, 2024 at 11:09:10AM +0100, Magnus Lindholm wrote:
> > On Sun, Dec 1, 2024 at 5:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> >
> > > Does booting with the "rcupdate.rcu_normal=3D1" kernel boot parameter
> > > also suppress the problem?
> >
> > setting rcupdate.rcu_normal=3D1 also suppresses the problem. I guess th=
is makes
> > RCU code not do synchronize_rcu_normal() in stead of the full
> > synchronize_rcu_expedited() which is where I get the kernel Oops.
>
> Exactly, though the effect is that any call to synchronize_rcu_expedited(=
)
> instead results in a call to synchronize_rcu().
>
> Which means that you can work around this problem without having to
> carry patches and without having to slow down network configuration for
> everyone else.  ;-)
>
> > > That "pc =3D" down below is the program counter?  If so, I am at a lo=
ss
> > > as to what RCU could do to make it be zero.
> >
> > No sure why this happens, if the RCU code is passing around pointers to
> > worker function and this somehow ends up being a null pointer on the Al=
pha?
>
> Are frame pointers enabled on your setup?  If not, could you please
> enable them and reproduce the problem?  Could you also please try
> building and reproducing with CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy?
>
>                                                         Thanx, Paul
