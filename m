Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783F1DA10C;
	Thu,  5 Dec 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413207; cv=none; b=MrUYIxirKDyjUkd5W5EjCBXJkv1J9sHcz6P2lxTgytCOUZNy5FAbUpn51RUOj33kBqeLnUD3Vgf/z65/AWKXluZpaO+IjuRA8vKVVoLhrfbPfJFvhNyU04554mn7GNSfGgbfFkPX5+mLY38OkYml7lYcpZ6arCbQfNK6TbSrJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413207; c=relaxed/simple;
	bh=J+x/ezzwy0fwgBPGY9JRwD84tvu4QWauBXBHR/sEKRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7Zzm5iU2LTVsqQkbrNZrsCquW6LAutCtLgBQUL+uRG/W914mNZxK+yjpEgoNUpneuuqIVY66KQfSS/AP4kA+/tM6vk/HfgPY0n83AJFdZRi5DY5VeE8FDv98IF8+74Yi/6t94CFXdCUNCr6PF2Ngv4bs53V6/MBiqA4xuG5QyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GVaAVLNd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GVaAVLNd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GEYPs8OAUvL6vSsE/sGVVNhUcj30WSpg4SOPJEKjVqU=; t=1733413203; x=1734018003; 
	b=GVaAVLNdlFNacEYbPXE47NjIvExTMi0NmUDEJd5fQLMGpA8Xqzk99+5PyKv69EYFkLI1JQQ4t3D
	yOIBdGCP41/4YucKaRJA91Q2/xEsDL9K349vQKWAjDIU/ew72LBMiYaTk10IsiVziY3s1zVLc4UDV
	yFa9Z/pxwVamJviorDsQ5YSRunISizubJmDacwhIx9vSyUiI09Q54jrCxhtqejANhOip5Y7Yi5Cet
	v94A7zcUh5Sh27hmZB10r6X868N0oQsrtH4/1XdnJcdAiUHSAiNP5Rd/soymWr09nHUuFyllRQWzT
	BhSRTongTwgeAN8W6Z+HSUdQE5pIvI614eMQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tJDxM-00000003eqY-05Kv; Thu, 05 Dec 2024 16:39:56 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tJDxL-000000033na-3NJu; Thu, 05 Dec 2024 16:39:55 +0100
Message-ID: <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>, paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Thu, 05 Dec 2024 16:39:55 +0100
In-Reply-To: <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
References: 
	<CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
	 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
	 <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
	 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
	 <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Magnus,

On Wed, 2024-12-04 at 23:22 +0100, Magnus Lindholm wrote:
> I've been looking a bit closer at the RCU problem on Alpha, in the
> case with the bug
> related to interface-renaming after the changes in the networking code
> the code fails
> with an invalid pointer reference. From the stack trace one can
> conclude that this
> happens when using synchronize_rcu_expedited() in stead of
> synchronize_rcu_normal().
> The use of rcu_normal can be enforced by setting kernel parameter
> rcupdate.rcu_normal=3D1
> at boot. This makes recent kernels boot again on my Alphas, a simple enou=
gh
> workaround for now.
>=20
> The code fails inside work-queue handler wait_rcu_exp_gp() when its
> trying to call
> rcu_exp_sel_wait_wake(). looking at the code generated from the
> compiler the call
> to rcu_exp_sel_wait_wake() appears to be inline-optimized, so no
> actual call to this
> function. If I add some bogus-code (i.e a print call that references
> the address of a
> local variable, something that the compiler can't optimize away)
> before the call to
> rcu_exp_sel_wait_wake(), the code works! The same effect is achieved
> by declaring
> the local variable as volatile.
>=20
> I've also noted a similar behavior in the scsi driver code, where
> unloading of a scsi
> driver kernel module (in my case qla1280) will trigger a kernel Oops. As =
in the
> example above, this can be mitigated by adding a reference to local varia=
bles.
> When doing "rmmod qla1280" scsi_host_dev_release() calls rcu_barrier(). I=
n this
> function call I noticed that the stack was somehow corrupted and the
> return address
> to scsi_host_dev_release() was overwritten. The stack corruption occurs i=
n the
> "for_each_possible_cpu(cpu)" loop inside rcu_barrier(). Below are stack d=
umps
> from before/after the for_each_possible_cpu loop. The call to
> scsi_host_dev_release
> disappears in stack trace since its return address (fffffc0000b6a3ec)
> is replaced
> by a '1' and at the of the call to rcu_barrier(). We get a kernel Oops
> since the $ra=3D1 is used as return address.
>=20
> In both RCU cases above, stack corruption occurs and the sections that ca=
use
> problems involve the use of kernel threads so concurrency might be an
> issue here.
> Since the RCU code works on other platforms and can be "fixed" on Alpha a=
s well
> just by declaring certain variables as volatile (or by other means
> making sure that
> they are not optimized away from the code) can this be a compiler issue o=
n
> alpha or is it the result of not taking proper measures, in the code,
> to account for the
> weak memory model on Alpha? Or a combination of the two?
>=20
>=20
> /Magnus Lindholm
>=20
>=20
> Stack traces showing the corrupted stack frames:
> ----------------------------------------------------------------
>=20
> rcu: inside rcu_barrier 5
> CPU: 1 UID: 0 PID: 1430 Comm: rmmod Not tainted 6.12.1-gentoo #43
>         fffffc000987fc88 fffffc0000e66440 fffffc00003a8bc8 00000000000000=
00
>         fffffc0000e667b0 fffffc000480b5d8 fffffc0000b6a3ec fffffc0004a2a0=
00
>         fffffc0004a2a240 fffffc000480b5d8 0000000000000000 fffffffc005020=
68
>         0000020001043480 00000200010422a0 0000000000000000 00000000000000=
00
>         fffffc0000b68efc fffffc0004a2a240 fffffc0006319300 00000000000000=
00
>         fffffc0000b2ed80 fffffc0004a2a240 fffffc0000b9d278 00000000000000=
00
>  Trace:
>  [<fffffc00003a8bc8>] rcu_barrier+0x1f8/0x580
>  [<fffffc0000b6a3ec>] scsi_host_dev_release+0xac/0x1cc
>  [<fffffc0000b68efc>] device_release+0x148/0x218
>  [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
>  [<fffffc00007cac3c>] put_device+0x1c/0x30
>  [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
>  [<fffffc00007554a4>] pci_device_remove+0x34/0x90
>  [<fffffc00007d5c04>] device_remove+0x64/0xb0
>  [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
>  [<fffffc00007d783c>] driver_detach+0x7c/0x110
>  [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
>  [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
>  [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
>  [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
>  [<fffffc0000310d34>] entSys+0xa4/0xc0
>=20
>=20
> rcu: inside rcu_barrier 6
> CPU: 1 UID: 0 PID: 1430 Comm: rmmod Not tainted 6.12.1-gentoo #43
>         fffffc000987fc88 fffffc0000e66440 fffffc00003a8c44 00000000000000=
02
>         fffffc0000e667b0 fffffc0000e44240 0000000000000001 fffffc0004a2a0=
00
>         fffffc0004a2a240 fffffc000480b5d8 0000000000000000 fffffffc005020=
68
>         0000020001043480 00000200010422a0 0000000000000000 00000000000000=
00
>         fffffc0000b68efc fffffc0004a2a240 fffffc0006319300 00000000000000=
00
>         fffffc0000b2ed80 fffffc0004a2a240 fffffc0000b9d278 00000000000000=
00
>  Trace:
>  [<fffffc00003a8c44>] rcu_barrier+0x274/0x580
>  [<fffffc0000b68efc>] device_release+0x148/0x218
>  [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
>  [<fffffc00007cac3c>] put_device+0x1c/0x30
>  [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
>  [<fffffc00007554a4>] pci_device_remove+0x34/0x90
>  [<fffffc00007d5c04>] device_remove+0x64/0xb0
>  [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
>  [<fffffc00007d783c>] driver_detach+0x7c/0x110
>  [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
>  [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
>  [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
>  [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
>  [<fffffc0000310d34>] entSys+0xa4/0xc0
>=20
>=20
> Unable to handle kernel paging request at virtual address 000000000000000=
0
> CPU 1
> rmmod(1430): Oops -1
>  pc =3D [<0000000000000000>]  ra =3D [<0000000000000001>]  ps =3D 0000   =
 Not tainted
>  pc is at 0x0
>  ra is at 0x1
>  v0 =3D 0000000000000007  t0 =3D fffffc0000ec7aa8  t1 =3D fffffffffffffff=
f
>  t2 =3D fffffc0000e65df0  t3 =3D 00000000000026f0  t4 =3D 00000000000028f=
1
>  t5 =3D 00000000000c2e20  t6 =3D 00000000000c2e68  t7 =3D fffffc000987c00=
0
>  s0 =3D fffffc0004a2a000  s1 =3D fffffc0004a2a240  s2 =3D fffffc000480b5d=
8
>  s3 =3D 0000000000000000  s4 =3D fffffffc00502068  s5 =3D 000002000104348=
0
>  s6 =3D 00000200010422a0
>  a0 =3D 0000000000000000  a1 =3D 0000000000000001  a2 =3D 00000000000028f=
0
>  a3 =3D fffffc000987fa38  a4 =3D 0000000000000000  a5 =3D 000000000000000=
0
>  t8 =3D 00000000000c2e20  t9 =3D ffffffffffffffec  t10=3D 000000000000000=
1
>  t11=3D 00000001000024f0  pv =3D fffffc000038a1f0  at =3D 000000000000000=
0
>  gp =3D fffffc0000eb7aa8  sp =3D 00000000183e6a07
>  Disabling lock debugging due to kernel taint
>  Trace:
>  [<fffffc0000b68efc>] device_release+0x148/0x218
>  [<fffffc0000b2ed80>] kobject_put+0x1d0/0x270
>  [<fffffc00007cac3c>] put_device+0x1c/0x30
>  [<fffffc00007f47cc>] scsi_host_put+0x1c/0x30
>  [<fffffc00007554a4>] pci_device_remove+0x34/0x90
>  [<fffffc00007d5c04>] device_remove+0x64/0xb0
>  [<fffffc00007d7694>] device_release_driver_internal+0x294/0x380
>  [<fffffc00007d783c>] driver_detach+0x7c/0x110
>  [<fffffc00007d5240>] bus_remove_driver+0xa0/0x150
>  [<fffffc00007d80c4>] driver_unregister+0x44/0xa0
>  [<fffffc00007552f8>] pci_unregister_driver+0x38/0xd0
>  [<fffffc00003bbb7c>] sys_delete_module+0x19c/0x320
>  [<fffffc0000310d34>] entSys+0xa4/0xc0
>=20
>=20
> Below are the changes I made to the kernel source in order mitigate
> the stack corruption problem
> this is not really a fix but it can be of use to gain further
> knowledge on whats really going on:
> -------------------------------------------------------------------------=
-----------
>=20
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ff98233d4aa5..8241313404f7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4553,7 +4553,7 @@ static void rcu_barrier_handler(void *cpu_in)
>   */
>  void rcu_barrier(void)
>  {
> -       uintptr_t cpu;
> +       volatile uintptr_t cpu;
>         unsigned long flags;
>         unsigned long gseq;
>         struct rcu_data *rdp;
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index fb664d3a01c9..afba0ebc80e4 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -477,7 +477,7 @@ static inline void
> sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
>   */
>  static void wait_rcu_exp_gp(struct kthread_work *wp)
>  {
> -       struct rcu_exp_work *rewp;
> +       volatile struct rcu_exp_work *rewp;
>=20
>         rewp =3D container_of(wp, struct rcu_exp_work, rew_work);
>         rcu_exp_sel_wait_wake(rewp->rew_s);
> @@ -705,6 +705,7 @@ static void rcu_exp_wait_wake(unsigned long s)
>   */
>  static void rcu_exp_sel_wait_wake(unsigned long s)
>  {
> +       pr_warn("inside rcu_exp_sel_wait_wake, %llx\n",(void*)s);
>         /* Initialize the rcu_node tree in preparation for the wait. */
>         sync_rcu_exp_select_cpus();

I wonder whether these RCU bugs are related to the SMP issue on alpha that'=
s
been introduced/uncovered by f2f84b05e02b7710a201f0017b3272ad7ef703d1 [1].

In particular, one suggestion was to run the RCU stress test and see if the
results will tell anything about issues that might be related to the SMP
problem.

Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D213143

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
