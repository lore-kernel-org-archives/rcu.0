Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE28C07
	for <rcu@vger.kernel.org>; Thu,  3 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964131; cv=none; b=rPGSGYGdobEhm+r3Nptk7CU+Yad2YqVwTPDuKanLX0iaCEibK4encPKm8+XSuZPFOiqW37qvp5Us+sGxzRJzxVMxW+XzaVZFQQRHzkW9zAAIrlywqx61g8aWtzrHO8AvOXL05o9GB+H7wIVb/1Fkc4NMuQLRTgo897wPdiRbOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964131; c=relaxed/simple;
	bh=N+punAUjEDR5R+Y5HscF5Hg6hRtwTffuMI3XRuclSUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLW0vJlqpNySajvy4RrWSJ/zprdGDOXO3vhIGcfP3xP2AO4y1o2SMXruEnDtNFeph2tzgOOYL5pJlNMokoDFfVHq3SZA/QYzGQSgGT2aCGysprN0XRmUauxc717IfS2t3VMVSMuTz1SB9J+wDLK6pbRWWVUYcgwnKcY1d+O6y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFpQdAce; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFpQdAce"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso619286a12.2
        for <rcu@vger.kernel.org>; Thu, 03 Oct 2024 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727964129; x=1728568929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BHJlmYWeIL4iMehc8hks8QUIooPrrdTbmu8Bs9Nfa8=;
        b=KFpQdAceN6DTQmTiRTl8HrryCscjY+cugqpKG4YMRexfA1V9gRt3hBO9NlRFmnqccp
         s5sfvDM+voJLtikGUmxkeak04gVPGk7joDDxxugTghg3eSxZKdvOuKy/Y/ncMJeD0pxz
         rSx++WmxL8VV15ekdAcRi/YiSYZ+ayelHVtGSxyikHMwdSEFlhHntlf0FkS5bvQ029GD
         xfGBhoFIRoQ7l0mVm7NRoGmBqQC4DjdzN8pFxNNYkMOqFj8L4lVYCfRB9e0dcsGysZKE
         lEM8evEa9Sc2Gb7c0CoyDL8aMWE//Ch/TwQtV8RjIeNgpVwGBmkkqvTn/wQRVKTGAQh2
         skkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727964129; x=1728568929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BHJlmYWeIL4iMehc8hks8QUIooPrrdTbmu8Bs9Nfa8=;
        b=PI33V9l80+VqLtbERiscExvlZXVFB8Crr1TJ9+8ntu3vwo9EDqtH57J68qhJYyLV6Q
         XkwrPUd7eBfTEx9fTui4dy7jI+9Qc+zq4TFbxDvxYWHqnUkpjbzTUNj59Lpck+sczXUj
         IfGG1HtVyrJ25WcPpeaG4Nh7NRuEjEF+6rNQMsoLiOnC1EBC3BO8oQiNOxdQiiz4IVAN
         XTYuvNlGmS83MpqcMy4S3m9crGGTTe+8NZ1RgPnTk/HYWiSltjQHunKzPfZ/9ggznzwj
         FVd29J2by4Ja6+SjwL73Sf32RZo0IpzFkU6aLU4qBHOTFvglEI+ac6iU5juutKnaVPNS
         iHmw==
X-Forwarded-Encrypted: i=1; AJvYcCVY42YsvZZcfqH7RSEB5y3Dd9sbdNkS67ri4gR5OE8iNEM/ihkY+EWYCzh8TcVMCHBZw0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjAmNariN5EhjiKkySWbqdtVi3+e9jMBLIdBGP/0gBc9OYYTS
	OOWLnKFGmBtaynNO2/i8UPrsGQTo9NbsPEUVi+KiXP+98KIqEIkoGHDRhCEYu54mwqqX/gAtHBZ
	X1RkO58X7tBZovV5kxckl/ebZLxn0FYOR
X-Google-Smtp-Source: AGHT+IE55GquluX2ksD0ICwRn0/wfI2UcQSUCj30gBbMFWQmb1cw1+G7Razo+4mJtMI3md4rh3qgjg2Pzv7+fI+JdNk=
X-Received: by 2002:a17:90b:4c09:b0:2c4:e333:35e5 with SMTP id
 98e67ed59e1d1-2e1849441damr9073600a91.36.1727964128960; Thu, 03 Oct 2024
 07:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop> <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain> <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain> <Ztn7PpfFiYDRBjWX@localhost.localdomain>
In-Reply-To: <Ztn7PpfFiYDRBjWX@localhost.localdomain>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 3 Oct 2024 22:01:57 +0800
Message-ID: <CALm+0cXA8LJM7RWO5uqowkN3-gZYidPuyXZoHOJi10cJja1qPQ@mail.gmail.com>
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a =C3=A9cri=
t :
> > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a =C3=A9crit=
 :
> > > > Yes, I'm preparing an update for the offending patch (which has one=
 more
> > > > embarassing issue while I'm going through it again).
> > >
> > > Very good, thank you!
> >
> > So my proposal for a replacement patch is this (to replace the patch
> > of the same name in Neeraj tree):
>
> FYI, the diffstat against the previous version of the same patch is as fo=
llows.
> The rationale being:
>
> 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_m=
utex
>
> 2) Once rcuoc is parked, we really _must_ observe the callback list count=
er decremented
>    after the barrier's completion.
>
> 3) This fixes another issue: rcuoc must be parked _before_
>    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequenc=
e
>    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concur=
rently,
>    leaving the nocb locked forever.
>
>

This WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)) warning still
occurs.
insmod rcutorture.ko torture_type=3Drcu fwd_progress=3D8 n_barrier_cbs=3D8
nocbs_nthreads=3D8 nocbs_toggle=3D100 onoff_interval=3D60 test_boost=3D2

I added some debug modifications:

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 97b99cd06923..f44eee88b8ad 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1042,6 +1042,20 @@ static bool
rcu_nocb_rdp_deoffload_wait_cond(struct rcu_data *rdp)
  return ret;
 }

+static void rcu_nocb_dump_cblist(struct rcu_segcblist *cblist, int ncheck)
+{
+ struct rcu_head *rhp;
+ int index =3D 0;
+
+ rhp =3D cblist->head;
+ while (rhp) {
+ pr_info("rcu_callback func: %ps\n", rhp->func);
+ if (++index >=3D ncheck)
+ break;
+ rhp =3D rhp->next;
+ }
+}
+
 static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
  unsigned long flags;
@@ -1065,7 +1079,8 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rd=
p)

  rcu_nocb_lock_irqsave(rdp, flags);
  WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
- WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+ if (WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)))
+ rcu_nocb_dump_cblist(&rdp->cblist, 10);
  rcu_nocb_unlock_irqrestore(rdp, flags);

  wake_gp =3D rcu_nocb_queue_toggle_rdp(rdp);

dmesg:

4,5360,150691992,-,caller=3DT453;WARNING: CPU: 4 PID: 453 at
kernel/rcu/tree_nocb.h:1082 rcu_nocb_rdp_deoffload+0x565/0x7e0
4,5361,150692011,-,caller=3DT453;Modules linked in: rcutorture torture
4,5362,150692040,-,caller=3DT453;CPU: 4 UID: 0 PID: 453 Comm:
rcu_nocb_toggle Not tainted
6.11.0-next-20240927-yoctodev-standard-dirty #67
3a2655b4a49977d4639e002ae2d5e9a4a1f2d7e2
4,5363,150692054,-,caller=3DT453;Hardware name: QEMU Standard PC (Q35 +
ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org
04/01/2014
4,5364,150692064,-,caller=3DT453;RIP: 0010:rcu_nocb_rdp_deoffload+0x565/0x7=
e0
4,5365,150692082,-,caller=3DT453;Code: 48 b8 00 00 00 00 00 fc ff df 80
3c 02 00 0f 85 f2 01 00 00 48 b8 22 01 00 00 00 00 ad de 48 89 83 e0
04 00 00 e9 fa fd ff ff <0f> 0b 48 8d bb a8 00 00 00 48 b8 00 00a
4,5366,150692092,-,caller=3DT453;RSP: 0018:ffff888006a0fcf8 EFLAGS: 0001000=
2
4,5367,150692114,-,caller=3DT453;RAX: 0000000000000001 RBX:
ffff88806ce103c0 RCX: 1ffff1100d9c2096
4,5368,150692124,-,caller=3DT453;RDX: 0000000000000000 RSI:
0000000000000008 RDI: ffff88806ce104b0
4,5369,150692133,-,caller=3DT453;RBP: ffff888006a0fda8 R08:
ffffed100d9c2097 R09: ffffed100d9c2097
4,5370,150692142,-,caller=3DT453;R10: ffffed100d9c2096 R11:
ffff88806ce104b7 R12: ffff88806ce105e0
4,5371,150692152,-,caller=3DT453;R13: ffff88806c2103c0 R14:
0000000000000246 R15: ffff88806ce104b0
4,5372,150692162,-,caller=3DT453;FS:  0000000000000000(0000)
GS:ffff88806c000000(0000) knlGS:0000000000000000
4,5373,150692174,-,caller=3DT453;CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
4,5374,150692183,-,caller=3DT453;CR2: 0000000000000000 CR3:
000000000bbd2000 CR4: 00000000001506f0
4,5375,150692193,-,caller=3DT453;Call Trace:
4,5376,150692202,-,caller=3DT453; <TASK>
4,5377,150692214,-,caller=3DT453; ? show_regs+0x65/0x70
4,5378,150692232,-,caller=3DT453; ? __warn+0xd5/0x310
4,5379,150692255,-,caller=3DT453; ? rcu_nocb_rdp_deoffload+0x565/0x7e0
4,5380,150692274,-,caller=3DT453; ? report_bug+0x23e/0x490
4,5381,150692312,-,caller=3DT453; ? handle_bug+0x5b/0xa0
4,5382,150692327,-,caller=3DT453; ? exc_invalid_op+0x1c/0x50
4,5383,150692346,-,caller=3DT453; ? asm_exc_invalid_op+0x1f/0x30
4,5384,150692398,-,caller=3DT453; ? rcu_nocb_rdp_deoffload+0x565/0x7e0
4,5385,150692420,-,caller=3DT453; ? rcu_nocb_rdp_deoffload+0x1f4/0x7e0
4,5386,150692448,-,caller=3DT453; ? __pfx_rcu_nocb_rdp_deoffload+0x10/0x10
4,5387,150692498,-,caller=3DT453; rcu_nocb_cpu_deoffload+0xb9/0x140
4,5388,150692521,-,caller=3DT453; rcu_nocb_toggle+0x2ac/0x3c0
[rcutorture 4065733c5816d1d4498e7501cdbf52edab89e7f2]
4,5389,150692547,-,caller=3DT453; ? _raw_spin_unlock_irqrestore+0x4a/0x80
4,5390,150692579,-,caller=3DT453; ? __pfx_rcu_nocb_toggle+0x10/0x10
[rcutorture 4065733c5816d1d4498e7501cdbf52edab89e7f2]
4,5391,150692620,-,caller=3DT453; ? __kthread_parkme+0xb8/0x1e0
4,5392,150692637,-,caller=3DT453; ? preempt_count_sub+0x124/0x1b0
4,5393,150692661,-,caller=3DT453; ? __kasan_check_read+0x15/0x20
4,5394,150692675,-,caller=3DT453; ? __kthread_parkme+0xc5/0x1e0
4,5395,150692699,-,caller=3DT453; ? __pfx_rcu_nocb_toggle+0x10/0x10
[rcutorture 4065733c5816d1d4498e7501cdbf52edab89e7f2]
4,5396,150692728,-,caller=3DT453; kthread+0x306/0x3e0
4,5397,150692746,-,caller=3DT453; ? __pfx_kthread+0x10/0x10
4,5398,150692767,-,caller=3DT453; ret_from_fork+0x40/0x70
4,5399,150692779,-,caller=3DT453; ? __pfx_kthread+0x10/0x10
4,5400,150692797,-,caller=3DT453; ret_from_fork_asm+0x1a/0x30
4,5401,150692863,-,caller=3DT453; </TASK>
4,5402,150692872,-,caller=3DT453;irq event stamp: 21504
4,5403,150692880,-,caller=3DT453;hardirqs last  enabled at (21503):
[<ffffffffb3680a63>] _raw_spin_unlock_irqrestore+0x63/0x80
4,5404,150692894,-,caller=3DT453;hardirqs last disabled at (21504):
[<ffffffffb03fc77e>] rcu_nocb_rdp_deoffload+0x3ee/0x7e0
4,5405,150692906,-,caller=3DT453;softirqs last  enabled at (21324):
[<ffffffffb01dd618>] handle_softirqs+0x428/0x800
4,5406,150692917,-,caller=3DT453;softirqs last disabled at (21315):
[<ffffffffb01de8ef>] irq_exit_rcu+0x1af/0x220
4,5407,150692927,-,caller=3DT453;---[ end trace 0000000000000000 ]---

When the rcuoc kthreads process rcu callback, before invoke
rcu_segcblist_add_len(&rdp->cblist, -count),
the rcu_barrier() can insert rcu_barrier_callback() func to offline
cpu rdp's->list.

6,5408,150692937,-,caller=3DT453;rcu: rcu_callback func: rcu_barrier_callba=
ck

Maybe we can wait until rcu_segcblist_n_cbs(&rdp->cblist) return zero
and then invoke kthread_parkme() in rcuoc kthreads.

Any thoughts ?

Thanks
Zqiang


> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 755ada098035..97b99cd06923 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1056,6 +1056,13 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data =
*rdp)
>         /* Flush all callbacks from segcblist and bypass */
>         rcu_barrier();
>
> +       /*
> +        * Make sure the rcuoc kthread isn't in the middle of a nocb lock=
ed
> +        * sequence while offloading is deactivated, along with nocb lock=
ing.
> +        */
> +       if (rdp->nocb_cb_kthread)
> +               kthread_park(rdp->nocb_cb_kthread);
> +
>         rcu_nocb_lock_irqsave(rdp, flags);
>         WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>         WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> @@ -1064,13 +1071,11 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data=
 *rdp)
>         wake_gp =3D rcu_nocb_queue_toggle_rdp(rdp);
>
>         mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> +
>         if (rdp_gp->nocb_gp_kthread) {
>                 if (wake_gp)
>                         wake_up_process(rdp_gp->nocb_gp_kthread);
>
> -               if (rdp->nocb_cb_kthread)
> -                       kthread_park(rdp->nocb_cb_kthread);
> -
>                 swait_event_exclusive(rdp->nocb_state_wq,
>                                       rcu_nocb_rdp_deoffload_wait_cond(rd=
p));
>         } else {
