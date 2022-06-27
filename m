Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D6CC43334
	for <rcu@archiver.kernel.org>; Mon, 27 Jun 2022 19:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiF0TWh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiF0TWg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jun 2022 15:22:36 -0400
Received: from sonic311-24.consmr.mail.gq1.yahoo.com (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47FB482
        for <rcu@vger.kernel.org>; Mon, 27 Jun 2022 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1656357753; bh=Sx+9s8DM3KEQiH6ZmBdBPKF4vpznb1KIa2ar/k1bSak=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=pRrUBWtorcCwiVC5tDpzz1IQBV6szTPMTAD1OlTELXBzAvkmG6sGBMDzAJJ3pBM3LYNOHG7K9HaYzx2TetfWYyEzW/deu8slbOlvrHmgdxcwZrSS3YFca1+mRMtokVg3C1mrdOnBpkhePciiKe45waJbD3bfLVnV2WLk1pXx8FF2Hd8TeAuLolKNfAUn250sP9l3PnkaUlH1Bwz8MPVffmerKJSg53mSXK0EbSFbr0jzLbGeL6rk7+0SnebCsOXToJ5Q7d2SgbX862FNQYHJyW5mTHpS6+DykUw70o4xw6P4kY03Hc7A5jWRTPp5Fz9J2o+TKKQL/KI8L1Jg/NFg4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656357753; bh=3BdKC2StOqgeRzbqbTeASGTdaoUzrnGhUae62YYvlNd=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=UdCKKIpbgI+r2YrSrtXW7GyxyjO4emUwItpv2M1VeDHaVnBpvMLCS748oyEmp0B79iXqY3pfztIqroMF+OvwvxsjqZAX0VKkuJQZIUbl9YtQext7Ib6WFdpJx7TaR1XHYdg/gEyXb805tVHBGkuQTa7YoVHT6Bfz1zMOyyb/dpRZsDmhzGSr0ZSQN1jDE6q3nZzytSoiVGPN8werP19BaX6O+7pEgXOSYqpcucIsKH9GOvrn99ImE3/ZyzhZ48VvxXqL6LDh96CRss/2qmt5PafMrkDOy37YgEhb0J5Mum/+DS6k8hDKgRGGQ3lNeNTWNmMg/lebooq/fuj1LU6XqA==
X-YMail-OSG: CEODN8IVM1lQsJlisA0rrWtTU.9K99Mu9stILRP1GZb_eKj47fzJgvlxVqb7l5M
 4PUS7kdUqAf7_Kj2oo.I3jbw2j.qy0cZ4lHqSi0KNRBq0zKbsO5m3wGHakpOBedllKSAUJ_YdIED
 pmXfKUNDFlTB_zrpWoxCnY5e53669oC74pRVz0zvAE3vJ3jx1ZFKHkumL9aJigB47PlKrkGLL86F
 wYChyQdf3.9uxNPcEvQ7AajDgVjE5EpFYvWQKilulUmiYpYLutdDILCNbNfteWV2oSJ5yzbgSAsd
 ou9dDalR6dcKimif5gZOYqmWCUm1AVdHPx4GIV8ZmA8L8fP7B5ZO_wdhTtepfFRMUXhWw7H4jIJO
 mska84KrBgo0tVcvPSB6D1BK5enLlJFJ2wTMHHS9E1EQCcUVIgBdiRnPH0UdGw_6Rpr5B4ERbmIF
 Qw9lOlpB02ICNIFRHxzrRv6N6x6f_31.OKE8dNXIh_wyYtEprynA00MEDYP4OTXJ1QZz9Wz1DQRL
 iqqLGRfs.VMeHzPS7dduuPQSAPMNGvDv6oJaI0d8kpWgafW2UiavDMpFWwE409qNxy1VyBIY2EP6
 pbgt9Wc0aOl34rgWED0OF77Bl1yViYE6yeAxFuBOKdBiZ6rJ1QKLJ5mCHnz5ZiDW5XWuFJAGlTfM
 YFJgzOv2Et96dAbAGY2rbeBu_ntvym9TSyBATFRBlQ96hm73reciIKNekccXKWVQWlco1Wmp4I26
 ns_y_nth268xPmhtmw3N6d46q4szmpdMOgX5E0AuX80jsgBi6Vvy0bkr9DBdnRLHSJsa_7NK9Am6
 WtlUrjkmawk.h_WAcClCofLZzF65pt..z8o6JJlCqqHhMkdgJ07Ej5QXKvh6jzEsmvvEIzb1lkcE
 _aKUhbm9MYOX9EASzfs40vXEHh28koI.XoM_ysw3qshzYsOHPHeF6_nvrqY8_WPbLS5aIeyoJzAq
 lahmXzEXvKeRKThx4cxPVESwBK.cP5bfwkaStSo698Oer3UTNfHYYSGx7EXkOt6rOnEHILs1VXXv
 r00nj1MldRHGw4aFW5hNrOLITFmNYwTkMvvTdn_MXQoSLnCB65h6vv6frONetYsZkKKp_7HhTOIi
 nzGASLTIBywyeaq8E39bb0bBI3VKQsV8eZyl3fx_8C5Tw1osi491hMw2gFwx5jg_CaD8UY.cHm3y
 hGiRyIA442sEL92DoT9gAmbL9pIksJT02qxUZN3APGqAhBFCiwyNeKW0.TyQHs6vatqOz43Zha90
 HuKTsznQNbopCYXAr3S1eiK4yqU4HQdt46iS_VANInCTg_5Ljqxa2U9SxiDtGN6.dSz.YjV9xXL2
 lku8Bm8R3_Lp8p.sLWZDIjgNy_UgAB.QTxgTBTbO02_bjdafdswxei6Cec5dfFpSVmwIZyaYnsnk
 9Ab.3bywivLGvW4Qi5HrLoNH4UrfbVVkbpFNF2CBKahJiyD2rWpxHE.35AY0rj7U5613BE0J_LOo
 OLknADwUawqfjnIYNcAS38wXAOuHDbS1KN_OwJp1jkyBz3yCTJrNBuOKSrMPFRmWBziOGayEawdy
 QGI7mimiljSAiLyu2N.UQ31m_kYkyKOdCulSl0uNEU51Gi6ZdwS3K67A8cVg9okwmVA99w.1yk57
 4QqUhhpGDEl3cO5L2UPfT.661Jmdu0lqwP4KkaEnWDVEkjczXyCxlzeLWl3jvUdP8PD013_5ySQj
 hHViq0ZYzW1j_v2xj5V.ynU8ivSD2FS04FgEKJ39CBu7vSRfGQfQqzXUHKeUVwWssIiP3DMSsDGm
 SfDM.a0kyRgKQ8Ehq0DoeYfLT7G2pE.bOZt1Yccn0230OzSS0R9tWNOdbTiN.oXOg.55iemQBKpA
 u8Y1ADECGcuXPlo5dGvuksaQzP_NG0AThhsCzCrwMiKVQT0V8brgXe2DTOr17KQWHFZ1UZTE0saC
 66hZ9.VvaPV7sD6nhj07qIBkWThylxO5ROev4Ak.TIUZ56SnYWpl51VlB6PACRS5oRJs3bFegytx
 dZdhIl7sSYbeiyAhoE1M0oprDoMBlVGKe0eHjL4D73Z6EZb6J.eWKCKFLji_yAnRhiR3f_nY0NDk
 rgRAEnApxmB3MfC_886AEcZMJXAJnV8lLyueWHW3gUaD_RBuwuagBX.6VcwGL8HerRm5HeKLi4a0
 YAMOi.LpMP8B.u21GrlkkW8X.0bxWbJoygPmclbUl0UHWQOaa0wtv8rakJg5nXKvDWHII6Cgw0OL
 1QjGjKRICY7C9c.g9rZvY74SN908my1tz79XSZWmmnb8FMALtd4kRiU7R
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 27 Jun 2022 19:22:33 +0000
Received: by hermes--production-bf1-7f5f59bd5b-fj9wt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8bef5f7698e462d1564fd760e8e275ef;
          Mon, 27 Jun 2022 19:22:27 +0000 (UTC)
Date:   Mon, 27 Jun 2022 15:22:24 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: rcu_sched detected expedited stalls in amdgpu after suspend
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        rcu@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1656357116.rhe0mufk6a.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1656357116.rhe0mufk6a.none.ref@localhost>
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Since Linux 5.19-ish, I consistently get these types of errors when=20
resuming from S3:

[15652.909157] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks=
: { 11-... } 7 jiffies s: 9981 root: 0x800/.
[15652.909162] rcu: blocking rcu_node structures (internal RCU debug):
[15652.909163] Task dump for CPU 11:
[15652.909164] task:kworker/u24:65  state:R  running task     stack:    0 p=
id:210218 ppid:     2 flags:0x00004008
[15652.909167] Workqueue: events_unbound async_run_entry_fn
[15652.909172] Call Trace:
[15652.909173]  <TASK>
[15652.909174]  ? atom_get_src_int+0x38e/0x680
[15652.909179]  ? atom_op_test+0x67/0x190
[15652.909181]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
[15652.909184]  ? atom_op_calltable+0xb1/0x110
[15652.909186]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
[15652.909189]  ? atom_op_calltable+0xb1/0x110
[15652.909191]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
[15652.909193]  ? __switch_to+0x137/0x440
[15652.909195]  ? amdgpu_atom_asic_init+0xe0/0x100
[15652.909198]  ? pci_bus_read_config_dword+0x36/0x50
[15652.909201]  ? amdgpu_device_resume+0x10b/0x3e0
[15652.909203]  ? amdgpu_pmops_resume+0x32/0x60
[15652.909204]  ? pci_pm_suspend+0x2b0/0x2b0
[15652.909206]  ? dpm_run_callback+0x35/0x1f0
[15652.909209]  ? device_resume+0x1ca/0x220
[15652.909211]  ? async_resume+0x19/0xe0
[15652.909213]  ? async_run_entry_fn+0x33/0x120
[15652.909215]  ? process_one_work+0x1d6/0x350
[15652.909218]  ? worker_thread+0x24d/0x480
[15652.909220]  ? kthread+0x137/0x150
[15652.909221]  ? worker_clr_flags+0x40/0x40
[15652.909224]  ? kthread_blkcg+0x30/0x30
[15652.909226]  ? ret_from_fork+0x22/0x30
[15652.909227]  </TASK>
[15653.015808] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks=
: { 11-... } 7 jiffies s: 9985 root: 0x800/.
[15653.015812] rcu: blocking rcu_node structures (internal RCU debug):
[15653.015813] Task dump for CPU 11:
[15653.015813] task:kworker/u24:65  state:R  running task     stack:    0 p=
id:210218 ppid:     2 flags:0x00004008
[15653.015816] Workqueue: events_unbound async_run_entry_fn
[15653.015820] Call Trace:
[15653.015820]  <TASK>
[15653.015821]  ? amdgpu_cgs_read_register+0x10/0x10
[15653.015825]  ? smu7_copy_bytes_to_smc+0xd4/0x200
[15653.015828]  ? polaris10_program_memory_timing_parameters+0x195/0x1b0
[15653.015831]  ? sysvec_apic_timer_interrupt+0xa/0x80
[15653.015834]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[15653.015836]  ? amdgpu_cgs_destroy_device+0x10/0x10
[15653.015839]  ? sysvec_apic_timer_interrupt+0xa/0x80
[15653.015841]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[15653.015843]  ? amdgpu_cgs_destroy_device+0x10/0x10
[15653.015846]  ? amdgpu_device_rreg+0x8f/0xd0
[15653.015847]  ? phm_wait_for_register_unequal+0x99/0xd0
[15653.015850]  ? smu7_send_msg_to_smc+0x95/0x130
[15653.015853]  ? smum_send_msg_to_smc+0x5d/0xa0
[15653.015854]  ? amdgpu_cgs_read_ind_register+0xa0/0xa0
[15653.015857]  ? smu7_enable_dpm_tasks+0x241f/0x28c0
[15653.015859]  ? hwmgr_resume+0x31/0x70
[15653.015861]  ? amdgpu_device_resume+0x1fa/0x3e0
[15653.015863]  ? amdgpu_pmops_resume+0x32/0x60
[15653.015864]  ? pci_pm_suspend+0x2b0/0x2b0
[15653.015866]  ? dpm_run_callback+0x35/0x1f0
[15653.015868]  ? device_resume+0x1ca/0x220
[15653.015870]  ? async_resume+0x19/0xe0
[15653.015872]  ? async_run_entry_fn+0x33/0x120
[15653.015874]  ? process_one_work+0x1d6/0x350
[15653.015877]  ? worker_thread+0x24d/0x480
[15653.015878]  ? kthread+0x137/0x150
[15653.015880]  ? worker_clr_flags+0x40/0x40
[15653.015882]  ? kthread_blkcg+0x30/0x30
[15653.015884]  ? ret_from_fork+0x22/0x30
[15653.015886]  </TASK>

I have not noticed any resulting problems. I am reporting this in the=20
hope that it is easy to fix the issue and remove the error messages=20
which may obscure some future problem.

Thanks,
Alex.
