Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B620B22
	for <rcu@vger.kernel.org>; Mon, 16 Sep 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463608; cv=none; b=luX4du+ozg8mmNNDRGlKIsNQQ1PFha4m6k//aQykxYMRChgQ6WfA5V+mTZcbujOs8WgKftP+ZW/+ReJpI5GlicTH62ceotwE5a+S7jSHQFV9dvS6m/IrjCBvu/Pb/DukKwr51nj2Wc53WKcbr+WWY7k6JnO09dBUOx4LkZrE/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463608; c=relaxed/simple;
	bh=l1I4Kj7MS0uZ36vfa+nx0fuIKF9QUpu5GU/VRHxOHCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0wtbRRZR827XzrJDwusJxhZlzqfINCv/x0o4YsXRMmhVK8RdpO5qZnGx+0KvWo/GsLLShw0KKIe8tEqlU8GUEG++E8R1RypKIXHX1j6mztdevWlDH1vukmjxmpLiisPKDnkEWSZGVmHHKihbfom89D1HB/XONQ9sADChCvtAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=rYfPC4qU; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=hVLyD5jL; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rYfPC4qU";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hVLyD5jL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1726463606; x=1757999606;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=l1I4Kj7MS0uZ36vfa+nx0fuIKF9QUpu5GU/VRHxOHCI=;
  b=rYfPC4qUSS7SvLGvSktY9xHZGxo35b0Ae9lnxA3ztiwhwUVtb4hNDhm3
   zCGv5dYYNpaEdnQNwKlbHdLCMlxVHFhW8P/ZtEZl+2+rZMRRb8KFvqMB9
   KT7n+UvukJBExxDlfjpu4LdPSIr3OhKwVZ4Hf8IVN60EsXDWiEQEawknO
   xJn/zT24QOkete+MY+NXEQXuVzxn4k2dn6IvhNFaCLBSUfy8U4SWV10CJ
   vB+zTUOtkvAZF2gDWXxMvuixOTkPr3JSGXAIYCUAweOSX3lb+5bjyDB2e
   ciVzE05ys0sFmr95d4QpakTfy9PnFNNEq0/TPL7nzxp6kZSeGmk6C2uxB
   w==;
X-CSE-ConnectionGUID: +YYgIOHORCabGp1rjOJjFg==
X-CSE-MsgGUID: 330NvGWoS9unEofjxToCWA==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2024 22:12:17 -0700
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a08d4ada12so59924935ab.3
        for <rcu@vger.kernel.org>; Sun, 15 Sep 2024 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1726463535; x=1727068335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QdWmq/Q/T8u56oau+i58TweteyHsviMP6YyNdUcBl4=;
        b=hVLyD5jLLkBr+Ybt2cVCV6/BTk/Pq44RCHn5ou0V0M+I7D5pjrzMQShuPJMu4eUK9R
         9yPohvlBqU3eDcHFv5GORSlto3MhLeKuWGUhoRnc2wORVASd2g+HxvTO4I1G7iQcq6x4
         3Fy5uwRk74mI6sv/E2Y2O4r8p+SiG4HAJDdv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726463535; x=1727068335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QdWmq/Q/T8u56oau+i58TweteyHsviMP6YyNdUcBl4=;
        b=xNbUJaYRyfTqOga1axPk47z692tNVsyen9deogQtIyS9TCtidSR1Yuiw5KMHD2eajm
         B2e9ghb6PVJRvqAiD8BjtIHkZWQ9UUw8N4dVwVcDiWyb9pSPjfUnI2O0/Y7DGwgCOID3
         V5Ig1haW/ecEpwJcvzEnFJGRrBXLtH+LdJ9MITng1UANMsuX4+CnsElYgNkEBRq4zJIm
         fUqeRWYtUm38yT4itIi/Ql93a2lrJ6PigdoVr47ydjMX4Xyl3KRjx5yPSdzW+BgW449N
         JPwouQ/3MiZFLfPSw6rgNkXtixQjP0/gahVZaCAmOQKW14izbIb5SHa/IBnm9A8kR4iJ
         TCcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0zYBouoD+ApM0SZJ5RCCJLl91jErOs8wivdXLzOKW+IdZoleH93SLAoWSv9cfkHzLoP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvF7FSB9E1r1YGDiUsvzsD+MmBd4FebFhwbsfZwRrdCa1LK4o
	YyqEDbIFmbwE12yKmI6GqOOJZgP/46fePGSPAUvvSfeb+6ZfRkPHOxIhA4R/8NsIRUWa+dX/6Fn
	ZAqjiTmCVlb5Ydydh9TSR59SDZhOHmAFHxMvbMEmL2VKqEl+GaNH6zkEePqtgOTvrk3rje/9YJU
	zQPHfPUZmcFx4+vdblk3nTVkaBWQ==
X-Received: by 2002:a05:6e02:12e7:b0:3a0:91fc:d0f8 with SMTP id e9e14a558f8ab-3a091fcd3aemr61682275ab.12.1726463535047;
        Sun, 15 Sep 2024 22:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2HIDlgRqg4lQxG3xHfTppvqCMZGQGbWG6g3U9zq2rhk7NNfZ/iPia2ZuBSN2TYY4+yPa9MX9SBTVnbMPbeH4=
X-Received: by 2002:a05:6e02:12e7:b0:3a0:91fc:d0f8 with SMTP id
 e9e14a558f8ab-3a091fcd3aemr61682155ab.12.1726463534329; Sun, 15 Sep 2024
 22:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636> <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
 <ZtieQFsSiALVVGld@pc636> <CALAgD-7WAY6FwTNGdt0BQ2S99Nr+yJ5XyWhA_L_SsbkKsHBrFw@mail.gmail.com>
 <ZuMR_U5JfZTIeG30@pc636> <CALAgD-5-Y1S34XqqGkNaO-fFiYAFODkDGiDrshaVLxGLcAYvYQ@mail.gmail.com>
In-Reply-To: <CALAgD-5-Y1S34XqqGkNaO-fFiYAFODkDGiDrshaVLxGLcAYvYQ@mail.gmail.com>
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sun, 15 Sep 2024 22:12:01 -0700
Message-ID: <CANikGpd-rkQh8EpygeLxcHrO1r+72G2bHA_MQ2CFExDK_KDe_Q@mail.gmail.com>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
To: Xingyu Li <xli399@ucr.edu>
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org, 
	boqun.feng@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After several tests, I found that the same PoC can cause multiple
different crashes for some unknown reason. Thus, I suspect that the
bug is capable of performing unintended memory writing without being
caught by KASAN.
I tested the PoC on the latest kernel, Linux 6.11 rc7 and it can still
cause crashes.
For reproducibility, I've created a GitHub repo at
https://github.com/TomAPU/Linux611BugReport, which contains the
software versions we used, the QEMU arguments we used to boot up the
kernel, the kernel config we used,  the pre-compiled kernel image,
Dockerfile that can be used to compile the kernel.
I hope this repo will be helpful for analyzing the bug.

Yours,
Juefei




On Sun, Sep 15, 2024 at 5:02=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Juefei will answer this. I already Cc'd him.
>
>
> On Thu, Sep 12, 2024 at 9:08=E2=80=AFAM Uladzislau Rezki <urezki@gmail.co=
m> wrote:
> >
> > > > >
> > > > > Here is the config file:
> > > > > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> > > > >
> > I tested your "reproducer" on 6.11.0-rc2. I see some panics and they ar=
e
> > different. For example below one triggers: BUG: kernel NULL pointer der=
eference, address: 0000000000000010
> >
> > <snip>
> > Linux pc640 6.11.0-rc2-00037-g6b376d473b12 #3833 SMP PREEMPT_DYNAMIC Th=
u Sep 12 15:42:02 CEST 2024 x86_64
> >
> > The programs included with the Debian GNU/Linux system are free softwar=
e;
> > the exact distribution terms for each program are described in the
> > individual files in /usr/share/doc/*/copyright.
> >
> > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > permitted by applicable law.
> > Last login: Thu Sep 12 11:13:52 EDT 2024 on ttyS0
> > uroot@pc640:~# /home/urezki/a.out
> > [  108.612276][ T8454] chnl_net:caif_netlink_parms(): no params data fo=
und
> > [  108.630121][ T8455] chnl_net:caif_netlink_parms(): no params data fo=
und
> > [  109.305626][ T8454] bridge0: port 1(bridge_slave_0) entered blocking=
 state
> > [  109.310125][ T8454] bridge0: port 1(bridge_slave_0) entered disabled=
 state
> > [  109.314806][ T8454] bridge_slave_0: entered allmulticast mode
> > [  109.321617][ T8454] bridge_slave_0: entered promiscuous mode
> > [  109.614547][ T8454] bridge0: port 2(bridge_slave_1) entered blocking=
 state
> > [  109.618924][ T8454] bridge0: port 2(bridge_slave_1) entered disabled=
 state
> > [  109.624061][ T8454] bridge_slave_1: entered allmulticast mode
> > [  109.630982][ T8454] bridge_slave_1: entered promiscuous mode
> > [  109.774534][ T8455] bridge0: port 1(bridge_slave_0) entered blocking=
 state
> > [  109.781204][ T8455] bridge0: port 1(bridge_slave_0) entered disabled=
 state
> > [  109.787878][ T8455] bridge_slave_0: entered allmulticast mode
> > [  109.792835][ T8455] bridge_slave_0: entered promiscuous mode
> > [  109.974516][ T8455] bridge0: port 2(bridge_slave_1) entered blocking=
 state
> > [  109.978872][ T8455] bridge0: port 2(bridge_slave_1) entered disabled=
 state
> > [  109.983548][ T8455] bridge_slave_1: entered allmulticast mode
> > [  109.988361][ T8455] bridge_slave_1: entered promiscuous mode
> > [  109.997251][ T8454] bond0: (slave bond_slave_0): Enslaving as an act=
ive interface with an up link
> > [  110.187177][ T8454] bond0: (slave bond_slave_1): Enslaving as an act=
ive interface with an up link
> > [  110.527036][ T8455] bond0: (slave bond_slave_0): Enslaving as an act=
ive interface with an up link
> > [  110.666716][ T8455] bond0: (slave bond_slave_1): Enslaving as an act=
ive interface with an up link
> > [  110.677591][ T8454] team0: Port device team_slave_0 added
> > [  110.836395][ T8454] team0: Port device team_slave_1 added
> > [  111.510715][ T8455] team0: Port device team_slave_0 added
> > [  111.626814][ T8455] team0: Port device team_slave_1 added
> > [  111.632180][ T8454] batman_adv: batadv0: Adding interface: batadv_sl=
ave_0
> > [  111.638793][ T8454] batman_adv: batadv0: The MTU of interface batadv=
_slave_0 is too small (1500) to handle the transport of batman-adv packets.=
 Packets going over this interface will be fragmented on layer2 which could=
 impact the performance. Setting the MTU to 1560 would solve the problem.
> > [  111.661108][ T8454] batman_adv: batadv0: Not using interface batadv_=
slave_0 (retrying later): interface not active
> > [  111.835012][ T8454] batman_adv: batadv0: Adding interface: batadv_sl=
ave_1
> > [  111.841107][ T8454] batman_adv: batadv0: The MTU of interface batadv=
_slave_1 is too small (1500) to handle the transport of batman-adv packets.=
 Packets going over this interface will be fragmented on layer2 which could=
 impact the performance. Setting the MTU to 1560 would solve the problem.
> > [  111.857352][ T8454] batman_adv: batadv0: Not using interface batadv_=
slave_1 (retrying later): interface not active
> > [  112.081965][ T8455] batman_adv: batadv0: Adding interface: batadv_sl=
ave_0
> > [  112.088499][ T8455] batman_adv: batadv0: The MTU of interface batadv=
_slave_0 is too small (1500) to handle the transport of batman-adv packets.=
 Packets going over this interface will be fragmented on layer2 which could=
 impact the performance. Setting the MTU to 1560 would solve the problem.
> > [  112.111075][ T8455] batman_adv: batadv0: Not using interface batadv_=
slave_0 (retrying later): interface not active
> > [  112.119385][ T8455] batman_adv: batadv0: Adding interface: batadv_sl=
ave_1
> > [  112.123657][ T8455] batman_adv: batadv0: The MTU of interface batadv=
_slave_1 is too small (1500) to handle the transport of batman-adv packets.=
 Packets going over this interface will be fragmented on layer2 which could=
 impact the performance. Setting the MTU to 1560 would solve the problem.
> > [  112.141098][ T8455] batman_adv: batadv0: Not using interface batadv_=
slave_1 (retrying later): interface not active
> > [  112.715591][ T8454] hsr_slave_0: entered promiscuous mode
> > [  112.801330][ T8454] hsr_slave_1: entered promiscuous mode
> > [  113.095845][ T8455] hsr_slave_0: entered promiscuous mode
> > [  113.171469][ T8455] hsr_slave_1: entered promiscuous mode
> > [  113.251172][ T8455] debugfs: Directory 'hsr0' with parent 'hsr' alre=
ady present!
> > [  113.261201][ T8455] Cannot create hsr debugfs directory
> > [  114.440022][ T8454] netdevsim netdevsim0 netdevsim0: renamed from et=
h0
> > [  114.508448][ T8454] netdevsim netdevsim0 netdevsim1: renamed from et=
h1
> > [  114.634433][ T8454] netdevsim netdevsim0 netdevsim2: renamed from et=
h2
> > [  114.744227][ T8454] netdevsim netdevsim0 netdevsim3: renamed from et=
h3
> > [  114.866169][ T8455] netdevsim netdevsim1 netdevsim0: renamed from et=
h0
> > [  114.974856][ T8455] netdevsim netdevsim1 netdevsim1: renamed from et=
h1
> > [  115.094399][ T8455] netdevsim netdevsim1 netdevsim2: renamed from et=
h2
> > [  115.198370][ T8455] netdevsim netdevsim1 netdevsim3: renamed from et=
h3
> > [  115.393414][ T8454] 8021q: adding VLAN 0 to HW filter on device bond=
0
> > [  115.428509][ T8454] 8021q: adding VLAN 0 to HW filter on device team=
0
> > [  115.445428][ T8455] 8021q: adding VLAN 0 to HW filter on device bond=
0
> > [  115.455183][  T841] bridge0: port 1(bridge_slave_0) entered blocking=
 state
> > [  115.463761][  T841] bridge0: port 1(bridge_slave_0) entered forwardi=
ng state
> > [  115.479368][  T142] bridge0: port 2(bridge_slave_1) entered blocking=
 state
> > [  115.487741][  T142] bridge0: port 2(bridge_slave_1) entered forwardi=
ng state
> > [  115.513042][ T8455] 8021q: adding VLAN 0 to HW filter on device team=
0
> > [  115.534056][  T841] bridge0: port 1(bridge_slave_0) entered blocking=
 state
> > [  115.540831][  T841] bridge0: port 1(bridge_slave_0) entered forwardi=
ng state
> > [  115.556733][ T1883] bridge0: port 2(bridge_slave_1) entered blocking=
 state
> > [  115.563088][ T1883] bridge0: port 2(bridge_slave_1) entered forwardi=
ng state
> > [  115.621249][ T8454] 8021q: adding VLAN 0 to HW filter on device bata=
dv0
> > [  115.662366][ T8455] 8021q: adding VLAN 0 to HW filter on device bata=
dv0
> > [  115.692483][ T8454] veth0_vlan: entered promiscuous mode
> > [  115.709197][ T8454] veth1_vlan: entered promiscuous mode
> > [  115.740423][ T8455] veth0_vlan: entered promiscuous mode
> > [  115.752797][ T8455] veth1_vlan: entered promiscuous mode
> > [  115.768040][ T8454] veth0_macvtap: entered promiscuous mode
> > [  115.776722][ T8454] veth1_macvtap: entered promiscuous mode
> > [  115.799794][ T8454] batman_adv: batadv0: Interface activated: batadv=
_slave_0
> > [  115.810688][ T8455] veth0_macvtap: entered promiscuous mode
> > [  115.823230][ T8454] batman_adv: batadv0: Interface activated: batadv=
_slave_1
> > [  115.832372][ T8455] veth1_macvtap: entered promiscuous mode
> > [  115.846846][ T8454] netdevsim netdevsim0 netdevsim0: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  115.855626][ T8454] netdevsim netdevsim0 netdevsim1: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  115.863223][ T8454] netdevsim netdevsim0 netdevsim2: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  115.869729][ T8454] netdevsim netdevsim0 netdevsim3: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  115.934253][ T8455] batman_adv: The newly added mac address (aa:aa:a=
a:aa:aa:3d) already exists on: batadv_slave_0
> > [  115.944230][ T8455] batman_adv: It is strongly recommended to keep m=
ac addresses unique to avoid problems!
> > [  115.954913][ T8455] batman_adv: batadv0: Interface activated: batadv=
_slave_0
> > [  116.054848][ T8455] batman_adv: The newly added mac address (aa:aa:a=
a:aa:aa:3e) already exists on: batadv_slave_1
> > [  116.064684][ T8455] batman_adv: It is strongly recommended to keep m=
ac addresses unique to avoid problems!
> > [  116.075471][ T8455] batman_adv: batadv0: Interface activated: batadv=
_slave_1
> > [  116.174807][ T8455] netdevsim netdevsim1 netdevsim0: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  116.183164][ T8455] netdevsim netdevsim1 netdevsim1: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  116.191693][ T8455] netdevsim netdevsim1 netdevsim2: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  116.199476][ T8455] netdevsim netdevsim1 netdevsim3: set [1, 0] type=
 2 family 0 port 6081 - 0
> > [  116.210161][ T8454] ieee80211 phy3: Selected rate control algorithm =
'minstrel_ht'
> > [  116.314373][ T1138] wlan0: Created IBSS using preconfigured BSSID 50=
:50:50:50:50:50
> > [  116.323148][ T1138] wlan0: Creating new IBSS network, BSSID 50:50:50=
:50:50:50
> > [  116.363438][ T8454] ieee80211 phy4: Selected rate control algorithm =
'minstrel_ht'
> > [  116.427601][ T8455] ieee80211 phy5: Selected rate control algorithm =
'minstrel_ht'
> > [  116.439923][   T12] wlan1: Created IBSS using preconfigured BSSID 50=
:50:50:50:50:50
> > [  116.447760][   T12] wlan1: Creating new IBSS network, BSSID 50:50:50=
:50:50:50
> > [  116.513068][   T12] wlan0: Created IBSS using preconfigured BSSID 50=
:50:50:50:50:50
> > [  116.515525][ T8455] ieee80211 phy6: Selected rate control algorithm =
'minstrel_ht'
> > [  116.517602][   T12] wlan0: Creating new IBSS network, BSSID 50:50:50=
:50:50:50
> > [  116.554182][  T120] wlan1: Created IBSS using preconfigured BSSID 50=
:50:50:50:50:50
> > [  116.562646][  T120] wlan1: Creating new IBSS network, BSSID 50:50:50=
:50:50:50
> > executing program
> > [  116.605018][T10471] program a.out is using a deprecated SCSI ioctl, =
please convert it to SG_IO
> > [  117.764915][   T65] netdevsim netdevsim1 netdevsim3 (unregistering):=
 unset [1, 0] type 2 family 0 port 6081 - 0
> > [  119.264267][   T65] netdevsim netdevsim1 netdevsim2 (unregistering):=
 unset [1, 0] type 2 family 0 port 6081 - 0
> > [  121.375536][   T65] netdevsim netdevsim1 netdevsim1 (unregistering):=
 unset [1, 0] type 2 family 0 port 6081 - 0
> > [  121.963598][   T65] netdevsim netdevsim1 netdevsim0 (unregistering):=
 unset [1, 0] type 2 family 0 port 6081 - 0
> > [  122.381273][   T65] bridge_slave_1: left allmulticast mode
> > [  122.389071][   T65] bridge_slave_1: left promiscuous mode
> > [  122.396906][   T65] bridge0: port 2(bridge_slave_1) entered disabled=
 state
> > [  122.601981][   T65] bridge_slave_0: left allmulticast mode
> > [  122.611091][   T65] bridge_slave_0: left promiscuous mode
> > [  122.617820][   T65] bridge0: port 1(bridge_slave_0) entered disabled=
 state
> > [  125.712116][   T65] bond0 (unregistering): (slave bond_slave_0): Rel=
easing backup interface
> > [  125.921681][   T65] bond0 (unregistering): (slave bond_slave_1): Rel=
easing backup interface
> > [  126.042002][   T65] bond0 (unregistering): Released all slaves
> > [  128.331207][   T65] hsr_slave_0: left promiscuous mode
> > [  128.461209][   T65] hsr_slave_1: left promiscuous mode
> > [  128.591184][   T65] batman_adv: batadv0: Interface deactivated: bata=
dv_slave_0
> > [  128.595352][   T65] batman_adv: batadv0: Removing interface: batadv_=
slave_0
> > [  128.655982][   T65] batman_adv: batadv0: Interface deactivated: bata=
dv_slave_1
> > [  128.664072][   T65] batman_adv: batadv0: Removing interface: batadv_=
slave_1
> > [  128.867924][   T65] veth1_macvtap: left promiscuous mode
> > [  128.875673][   T65] veth0_macvtap: left promiscuous mode
> > [  128.882671][   T65] veth1_vlan: left promiscuous mode
> > [  128.889132][   T65] veth0_vlan: left promiscuous mode
> > [  138.513086][   T65] team0 (unregistering): Port device team_slave_1 =
removed
> > [  139.601978][   T65] team0 (unregistering): Port device team_slave_0 =
removed
> > [  150.514196][ T1333] ieee802154 phy0 wpan0: encryption failed: -22
> > [  150.531082][ T1333] ieee802154 phy1 wpan1: encryption failed: -22
> > [  181.351814][ T1058] ata1: lost interrupt (Status 0x58)
> > [  182.061440][ T1058] ata1: found unknown device (class 0)
> > executing program
> > [  182.101661][T10525] program a.out is using a deprecated SCSI ioctl, =
please convert it to SG_IO
> > [  182.331131][    C7] BUG: kernel NULL pointer dereference, address: 0=
000000000000010
> > [  182.339044][    C7] #PF: supervisor read access in kernel mode
> > [  182.345673][    C7] #PF: error_code(0x0000) - not-present page
> > [  182.352216][    C7] PGD 150394067 P4D 150394067 PUD 192e9f067 PMD 0
> > [  182.359123][    C7] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > [  182.365905][    C7] CPU: 7 UID: 0 PID: 54 Comm: ksoftirqd/7 Not tain=
ted 6.11.0-rc2-00037-g6b376d473b12 #3833
> > [  182.375040][    C7] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  182.382819][    C7] RIP: 0010:stack_depot_save_flags+0x147/0x8d0
> > [  182.388239][    C7] Code: c1 e1 04 4c 03 0d 81 1d c8 0f 65 ff 05 5a =
ae 92 7b 49 8b 09 49 39 c9 75 11 e9 91 00 00 00 48 8b 09 49 39 c9 0f 84 a4 =
01 00 00 <39> 59 10 75 ef 44 3b 79 14 75 e9 31 c0 48 8b 54 c1 20 49 39 54 c=
5
> > [  182.399223][    C7] RSP: 0018:ffffc90006657970 EFLAGS: 00010286
> > [  182.402848][    C7] RAX: 00000000f759be75 RBX: 00000000f759be75 RCX:=
 0000000000000000
> > [  182.407055][    C7] RDX: 0000000018e8f28b RSI: 000000004a278650 RDI:=
 00000000bc02d21f
> > [  182.411271][    C7] RBP: 0000000000000001 R08: 0000000000000005 R09:=
 ffff88901cdbe750
> > [  182.415500][    C7] R10: 0000000000000000 R11: 0000000000000000 R12:=
 0000000000000000
> > [  182.419717][    C7] R13: ffffc900066579d0 R14: 000000000000000e R15:=
 000000000000000e
> > [  182.423938][    C7] FS:  0000000000000000(0000) GS:ffff88901d780000(=
0000) knlGS:0000000000000000
> > [  182.428464][    C7] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  182.432274][    C7] CR2: 0000000000000010 CR3: 00000001730ac000 CR4:=
 00000000000006f0
> > [  182.436523][    C7] Call Trace:
> > [  182.439244][    C7]  <TASK>
> > [  182.441839][    C7]  ? show_regs+0x88/0x90
> > [  182.444877][    C7]  ? __die+0x28/0x80
> > [  182.447798][    C7]  ? page_fault_oops+0x3b6/0xb80
> > [  182.451009][    C7]  ? copy_from_kernel_nofault_allowed+0xe6/0x110
> > [  182.454703][    C7]  ? __pfx_page_fault_oops+0x10/0x10
> > [  182.458029][    C7]  ? copy_from_kernel_nofault+0x12f/0x2c0
> > [  182.461515][    C7]  ? __sanitizer_cov_trace_switch+0x50/0x90
> > [  182.465062][    C7]  ? stack_depot_save_flags+0x147/0x8d0
> > [  182.468496][    C7]  ? is_prefetch.constprop.0+0x9d/0x520
> > [  182.471883][    C7]  ? stack_depot_save_flags+0x156/0x8d0
> > [  182.475300][    C7]  ? __pfx_is_prefetch.constprop.0+0x10/0x10
> > [  182.478866][    C7]  ? fixup_exception+0x108/0xae0
> > [  182.482081][    C7]  ? kernelmode_fixup_or_oops.constprop.0+0xb8/0xe=
0
> > [  182.485867][    C7]  ? __bad_area_nosemaphore+0x390/0x6a0
> > [  182.489306][    C7]  ? ret_from_fork_asm+0x19/0x30
> > [  182.492554][    C7]  ? do_user_addr_fault+0x928/0x12c0
> > [  182.495874][    C7]  ? rcu_is_watching+0xe/0xc0
> > [  182.499002][    C7]  ? exc_page_fault+0x57/0xd0
> > [  182.502122][    C7]  ? asm_exc_page_fault+0x22/0x30
> > [  182.505376][    C7]  ? stack_depot_save_flags+0x147/0x8d0
> > [  182.508798][    C7]  ? __lock_acquire+0xd09/0x5d30
> > [  182.512038][    C7]  ? i_callback+0x5d/0x70
> > [  182.515071][    C7]  kasan_save_stack+0x3e/0x50
> > [  182.518234][    C7]  ? kasan_save_stack+0x2f/0x50
> > [  182.521420][    C7]  ? kasan_save_track+0x10/0x30
> > [  182.524622][    C7]  ? kasan_save_free_info+0x37/0x60
> > [  182.527907][    C7]  ? poison_slab_object+0xf7/0x160
> > [  182.531169][    C7]  ? __kasan_slab_free+0x2e/0x50
> > [  182.534346][    C7]  ? kmem_cache_free+0x12b/0x4a0
> > [  182.537489][    C7]  ? i_callback+0x5d/0x70
> > [  182.540435][    C7]  ? rcu_core+0x84d/0x1c60
> > [  182.543390][    C7]  ? handle_softirqs+0x219/0x980
> > [  182.546499][    C7]  ? run_ksoftirqd+0x36/0x60
> > [  182.549492][    C7]  ? smpboot_thread_fn+0x660/0xa10
> > [  182.552629][    C7]  ? kthread+0x336/0x440
> > [  182.555447][    C7]  ? ret_from_fork+0x44/0x70
> > [  182.558334][    C7]  ? ret_from_fork_asm+0x1a/0x30
> > [  182.561276][    C7]  kasan_save_track+0x10/0x30
> > [  182.564051][    C7]  kasan_save_free_info+0x37/0x60
> > [  182.566922][    C7]  poison_slab_object+0xf7/0x160
> > [  182.569747][    C7]  __kasan_slab_free+0x2e/0x50
> > [  182.572530][    C7]  kmem_cache_free+0x12b/0x4a0
> > [  182.575296][    C7]  ? i_callback+0x5d/0x70
> > [  182.577922][    C7]  ? rcu_core+0x848/0x1c60
> > [  182.580554][    C7]  i_callback+0x5d/0x70
> > [  182.583066][    C7]  rcu_core+0x84d/0x1c60
> > [  182.585582][    C7]  ? __pfx_rcu_core+0x10/0x10
> > [  182.588229][    C7]  handle_softirqs+0x219/0x980
> > [  182.590882][    C7]  ? __pfx_handle_softirqs+0x10/0x10
> > [  182.593717][    C7]  ? rcu_is_watching+0xe/0xc0
> > [  182.596347][    C7]  ? __pfx_run_ksoftirqd+0x10/0x10
> > [  182.599104][    C7]  ? smpboot_thread_fn+0x599/0xa10
> > [  182.601869][    C7]  run_ksoftirqd+0x36/0x60
> > [  182.604434][    C7]  smpboot_thread_fn+0x660/0xa10
> > [  182.607152][    C7]  ? __kthread_parkme+0x148/0x220
> > [  182.609906][    C7]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [  182.612801][    C7]  kthread+0x336/0x440
> > [  182.615219][    C7]  ? _raw_spin_unlock_irq+0x1f/0x50
> > [  182.618023][    C7]  ? __pfx_kthread+0x10/0x10
> > [  182.620623][    C7]  ret_from_fork+0x44/0x70
> > [  182.623162][    C7]  ? __pfx_kthread+0x10/0x10
> > [  182.625755][    C7]  ret_from_fork_asm+0x1a/0x30
> > [  182.628385][    C7]  </TASK>
> > [  182.630443][    C7] Modules linked in:
> > [  182.632779][    C7] CR2: 0000000000000010
> > [  182.635183][    C7] ---[ end trace 0000000000000000 ]---
> > [  182.638056][    C7] RIP: 0010:stack_depot_save_flags+0x147/0x8d0
> > [  182.641146][    C7] Code: c1 e1 04 4c 03 0d 81 1d c8 0f 65 ff 05 5a =
ae 92 7b 49 8b 09 49 39 c9 75 11 e9 91 00 00 00 48 8b 09 49 39 c9 0f 84 a4 =
01 00 00 <39> 59 10 75 ef 44 3b 79 14 75 e9 31 c0 48 8b 54 c1 20 49 39 54 c=
5
> > [  182.649808][    C7] RSP: 0018:ffffc90006657970 EFLAGS: 00010286
> > [  182.653031][    C7] RAX: 00000000f759be75 RBX: 00000000f759be75 RCX:=
 0000000000000000
> > [  182.656897][    C7] RDX: 0000000018e8f28b RSI: 000000004a278650 RDI:=
 00000000bc02d21f
> > [  182.660748][    C7] RBP: 0000000000000001 R08: 0000000000000005 R09:=
 ffff88901cdbe750
> > [  182.664628][    C7] R10: 0000000000000000 R11: 0000000000000000 R12:=
 0000000000000000
> > [  182.668435][    C7] R13: ffffc900066579d0 R14: 000000000000000e R15:=
 000000000000000e
> > [  182.672198][    C7] FS:  0000000000000000(0000) GS:ffff88901d780000(=
0000) knlGS:0000000000000000
> > [  182.676268][    C7] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  182.679617][    C7] CR2: 0000000000000010 CR3: 00000001730ac000 CR4:=
 00000000000006f0
> > [  182.683435][    C7] Kernel panic - not syncing: Fatal exception in i=
nterrupt
> > [  182.687412][    C7] Kernel Offset: disabled
> > <snip>
> >
> > second one:
> >
> > <snip>
> > [  657.192361][    C0] list_add corruption. next->prev should be prev (=
ffff8881996a2670), but was 0000000000000000. (next=3Dffff8881a3571000).
> > [  657.204270][    C0] ------------[ cut here ]------------
> > [  657.210763][    C0] kernel BUG at lib/list_debug.c:29!
> > [  657.217140][    C0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASA=
N NOPTI
> > [  657.224382][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tain=
ted 6.11.0-rc2-00037-g6b376d473b12 #3833
> > [  657.233350][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  657.241232][    C0] RIP: 0010:__list_add_valid_or_report+0xa2/0x100
> > [  657.246703][    C0] Code: c7 c7 e0 2e 2a 8b e8 4d 3d 24 fd 0f 0b 48 =
c7 c7 80 2f 2a 8b e8 3f 3d 24 fd 0f 0b 48 89 d9 48 c7 c7 e0 2f 2a 8b e8 2e =
3d 24 fd <0f> 0b 48 89 f1 48 c7 c7 60 30 2a 8b 48 89 de e8 1a 3d 24 fd 0f 0=
b
> > [  657.257782][    C0] RSP: 0018:ffffc9000434f458 EFLAGS: 00010082
> > [  657.261306][    C0] RAX: 0000000000000075 RBX: ffff8881a3571000 RCX:=
 ffffffff816b4fb9
> > [  657.265447][    C0] RDX: 0000000000000000 RSI: ffffffff816bef02 RDI:=
 0000000000000005
> > [  657.269555][    C0] RBP: ffff8881b1b40d40 R08: 0000000000000005 R09:=
 0000000000000000
> > [  657.273686][    C0] R10: 0000000000000101 R11: 0000000000000001 R12:=
 ffff8881996a2670
> > [  657.277798][    C0] R13: 0000000000000820 R14: ffff8881b1b40d40 R15:=
 ffff8881a3571000
> > [  657.281918][    C0] FS:  0000000000000000(0000) GS:ffff88861fc00000(=
0000) knlGS:0000000000000000
> > [  657.286383][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  657.290128][    C0] CR2: 00007f4027088128 CR3: 000000000d17c000 CR4:=
 00000000000006f0
> > [  657.294297][    C0] Call Trace:
> > [  657.297076][    C0]  <TASK>
> > [  657.299729][    C0]  ? show_regs+0x88/0x90
> > [  657.302756][    C0]  ? die+0x32/0xa0
> > [  657.305654][    C0]  ? do_trap+0x232/0x430
> > [  657.308703][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.312223][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.315709][    C0]  ? do_error_trap+0xf4/0x230
> > [  657.318839][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.322308][    C0]  ? handle_invalid_op+0x34/0x40
> > [  657.325530][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.329015][    C0]  ? exc_invalid_op+0x29/0x40
> > [  657.332190][    C0]  ? asm_exc_invalid_op+0x16/0x20
> > [  657.335452][    C0]  ? __wake_up_klogd.part.0+0x99/0xf0
> > [  657.338814][    C0]  ? vprintk+0x82/0x90
> > [  657.341768][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.345267][    C0]  ? __list_add_valid_or_report+0xa2/0x100
> > [  657.348732][    C0]  ? ref_tracker_alloc+0x205/0x5a0
> > [  657.352010][    C0]  ref_tracker_alloc+0x236/0x5a0
> > [  657.355208][    C0]  ? __pfx_ref_tracker_alloc+0x10/0x10
> > [  657.358533][    C0]  ? dst_init+0xd6/0x570
> > [  657.361499][    C0]  ? dst_alloc+0xb7/0x1a0
> > [  657.364473][    C0]  ? ip6_dst_alloc+0x28/0xa0
> > [  657.367536][    C0]  ? icmp6_dst_alloc+0x6c/0x4a0
> > [  657.370635][    C0]  ? ndisc_send_skb+0x1275/0x1c20
> > [  657.373740][    C0]  ? ndisc_send_rs+0x127/0x690
> > [  657.376821][    C0]  ? addrconf_rs_timer+0x41e/0x850
> > [  657.379973][    C0]  ? call_timer_fn+0x1a3/0x600
> > [  657.383021][    C0]  ? __run_timers+0x749/0xae0
> > [  657.386018][    C0]  ? timer_expire_remote+0xfb/0x160
> > [  657.389128][    C0]  ? tmigr_handle_remote+0x7c7/0xfc0
> > [  657.392261][    C0]  ? run_timer_softirq+0x31/0x40
> > [  657.395251][    C0]  ? handle_softirqs+0x219/0x980
> > [  657.398195][    C0]  ? run_ksoftirqd+0x36/0x60
> > [  657.401024][    C0]  ? smpboot_thread_fn+0x660/0xa10
> > [  657.404017][    C0]  ? kthread+0x336/0x440
> > [  657.406708][    C0]  ? rcu_is_watching+0xe/0xc0
> > [  657.409508][    C0]  dst_init+0xd6/0x570
> > [  657.412090][    C0]  dst_alloc+0xb7/0x1a0
> > [  657.414630][    C0]  ip6_dst_alloc+0x28/0xa0
> > [  657.417183][    C0]  icmp6_dst_alloc+0x6c/0x4a0
> > [  657.419786][    C0]  ndisc_send_skb+0x1275/0x1c20
> > [  657.422420][    C0]  ? validate_store+0x1e/0x60
> > [  657.425004][    C0]  ? __pfx_ndisc_send_skb+0x10/0x10
> > [  657.427726][    C0]  ? __build_skb_around+0x278/0x3b0
> > [  657.430441][    C0]  ? __alloc_skb+0x1fc/0x380
> > [  657.432973][    C0]  ? skb_put+0x134/0x1a0
> > [  657.435368][    C0]  ndisc_send_rs+0x127/0x690
> > [  657.437856][    C0]  addrconf_rs_timer+0x41e/0x850
> > [  657.440437][    C0]  ? __pfx_addrconf_rs_timer+0x10/0x10
> > [  657.443169][    C0]  ? try_to_wake_up+0x13b/0x15d0
> > [  657.445750][    C0]  ? __pfx_lock_release+0x10/0x10
> > [  657.448369][    C0]  call_timer_fn+0x1a3/0x600
> > [  657.450828][    C0]  ? __pfx_addrconf_rs_timer+0x10/0x10
> > [  657.453586][    C0]  ? __pfx_call_timer_fn+0x10/0x10
> > [  657.456234][    C0]  ? __pfx_lock_release+0x10/0x10
> > [  657.458856][    C0]  ? __pfx_addrconf_rs_timer+0x10/0x10
> > [  657.461613][    C0]  ? __pfx_addrconf_rs_timer+0x10/0x10
> > [  657.464365][    C0]  __run_timers+0x749/0xae0
> > [  657.466804][    C0]  ? __pfx___run_timers+0x10/0x10
> > [  657.469401][    C0]  ? __pfx_lock_acquire+0x10/0x10
> > [  657.471986][    C0]  ? lock_acquire+0x1ad/0x550
> > [  657.474472][    C0]  timer_expire_remote+0xfb/0x160
> > [  657.477069][    C0]  ? __pfx_timer_expire_remote+0x10/0x10
> > [  657.479850][    C0]  ? _raw_spin_unlock_irq+0x1f/0x50
> > [  657.482475][    C0]  ? lockdep_hardirqs_on+0x78/0x100
> > [  657.485141][    C0]  tmigr_handle_remote+0x7c7/0xfc0
> > [  657.487771][    C0]  ? __pfx_tmigr_handle_remote+0x10/0x10
> > [  657.490551][    C0]  ? run_timer_base+0x11e/0x190
> > [  657.493102][    C0]  ? __pfx_run_timer_base+0x10/0x10
> > [  657.495762][    C0]  run_timer_softirq+0x31/0x40
> > [  657.498286][    C0]  handle_softirqs+0x219/0x980
> > [  657.500812][    C0]  ? __pfx_handle_softirqs+0x10/0x10
> > [  657.503503][    C0]  ? rcu_is_watching+0xe/0xc0
> > [  657.506009][    C0]  ? __pfx_run_ksoftirqd+0x10/0x10
> > [  657.508657][    C0]  ? smpboot_thread_fn+0x599/0xa10
> > [  657.511301][    C0]  run_ksoftirqd+0x36/0x60
> > [  657.513734][    C0]  smpboot_thread_fn+0x660/0xa10
> > [  657.516336][    C0]  ? __kthread_parkme+0x148/0x220
> > [  657.518950][    C0]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [  657.521715][    C0]  kthread+0x336/0x440
> > [  657.524064][    C0]  ? _raw_spin_unlock_irq+0x1f/0x50
> > [  657.526737][    C0]  ? __pfx_kthread+0x10/0x10
> > [  657.529240][    C0]  ret_from_fork+0x44/0x70
> > [  657.531687][    C0]  ? __pfx_kthread+0x10/0x10
> > [  657.534185][    C0]  ret_from_fork_asm+0x1a/0x30
> > [  657.536744][    C0]  </TASK>
> > [  657.538752][    C0] Modules linked in:
> > [  657.541038][    C0] ---[ end trace 0000000000000000 ]---
> > [  657.543837][    C0] RIP: 0010:__list_add_valid_or_report+0xa2/0x100
> > [  657.546921][    C0] Code: c7 c7 e0 2e 2a 8b e8 4d 3d 24 fd 0f 0b 48 =
c7 c7 80 2f 2a 8b e8 3f 3d 24 fd 0f 0b 48 89 d9 48 c7 c7 e0 2f 2a 8b e8 2e =
3d 24 fd <0f> 0b 48 89 f1 48 c7 c7 60 30 2a 8b 48 89 de e8 1a 3d 24 fd 0f 0=
b
> > [  657.555312][    C0] RSP: 0018:ffffc9000434f458 EFLAGS: 00010082
> > [  657.558444][    C0] RAX: 0000000000000075 RBX: ffff8881a3571000 RCX:=
 ffffffff816b4fb9
> > [  657.562186][    C0] RDX: 0000000000000000 RSI: ffffffff816bef02 RDI:=
 0000000000000005
> > [  657.565917][    C0] RBP: ffff8881b1b40d40 R08: 0000000000000005 R09:=
 0000000000000000
> > [  657.569676][    C0] R10: 0000000000000101 R11: 0000000000000001 R12:=
 ffff8881996a2670
> > [  657.573430][    C0] R13: 0000000000000820 R14: ffff8881b1b40d40 R15:=
 ffff8881a3571000
> > [  657.577198][    C0] FS:  0000000000000000(0000) GS:ffff88861fc00000(=
0000) knlGS:0000000000000000
> > [  657.581305][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  657.584702][    C0] CR2: 00007f4027088128 CR3: 000000000d17c000 CR4:=
 00000000000006f0
> > [  657.588528][    C0] Kernel panic - not syncing: Fatal exception in i=
nterrupt
> > [  657.592637][    C0] Kernel Offset: disabled
> > <snip>
> >
> > is about list corruption BUG. So they are different and looks like
> > something is corrupted. So i would not trust that your report is about
> > kvfree_rcu_bulk() warning is related to a real issue with kvfree_rcu()
> > call.
> >
> > A also run the reproducer on the 6.11.0-rc7 kernel. It still runs
> > without any panics yet.
> >
> > Could you please test the latest kernel? For example 6.11.0-rc7?
> >
> > --
> > Uladzislau Rezki
>
>
>
> --
> Yours sincerely,
> Xingyu
