Return-Path: <SRS0=0ICO=3L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D251AC32771
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 04:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9349F21835
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 04:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YcTVIbeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVEQJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:16:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41503 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgAVEQJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 23:16:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so4607510qtk.8
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2020 20:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zD3K7HBo8wdGzo+ZNwmoW64gFO0puClShAVH3lTaDpo=;
        b=YcTVIbeo++dVAUBoD9vHnBInl530xPF+NQdlNShVwf2ApVm+ej/3zgW0nPcC0c3UWr
         bXB9yk6xpPrntA5xupMqtunfCAv3uAaTLG6gEZQfICNJXp1zMqEwr2ZMHV3GdMf1IXkH
         xW1iyz/xrVcxCrs8XPSkDgujNvsdJqZhKqT1R5/WC8H4jPpV07XGrk7lgFFij621jiT5
         j4Du1wr8uaSLwcKWmwmFVjATm5TuEiFdJTmFNebR+zvQUfKhFMdG8zKRLFz57TYY9tNH
         RksfESl92eGx00PPEmrMlJz1658PeqmXVX+YSrVYWjkYqakuPPMpNjc14reyo0opDVqd
         G65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zD3K7HBo8wdGzo+ZNwmoW64gFO0puClShAVH3lTaDpo=;
        b=IAPGPKEJbJXfyBiMY+GhdR0tXeHLvgtrx6m//10THcOXi5Wtj5Jqu2RbsKuU179cvm
         mJsBfyJ6aU9lgKiJ5+qXzrsbEr9FCNZMo9VZLOCcGxEKrowXt1XKS8BgQUcZofDxgSMq
         564iRksU4nM0uUYQ6of6SfaIr5eiJSj7ROFfX69f41Iw/bmb0eu+CS1XgPUMti3N7RY1
         j0Wj2IXSK9qzzQztpVoA6O2c+PCtt6P5H85BKWLZqbQiMgzKlpRNL7QvpJWwz5yoRVOG
         w1305yU7JOVKvK/QwTJ3nNCqf4b8Fv+ClK3qWwdQH6dQ9uVnuP0c8L4fmlfUw9LBtMsq
         EfpA==
X-Gm-Message-State: APjAAAUznXBDMHNFq8Y/xhdN7qyUW541rp/tG6aX5cOwlmyBOYVZboy8
        exfmhkkbKv2vgrczAbGPOd9TBg==
X-Google-Smtp-Source: APXvYqyJ/LOhqQFwIjRG4mrYgVU09q61lT6WeoA/+pLUB/mqsiqGn3zXVAKClU8q+JToRs8Sk5U7PQ==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr8137933qtq.371.1579666568111;
        Tue, 21 Jan 2020 20:16:08 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o6sm17998544qkk.53.2020.01.21.20.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 20:16:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Boot warning at rcu_check_gp_start_stall()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121204606.GZ2935@paulmck-ThinkPad-P72>
Date:   Tue, 21 Jan 2020 23:16:06 -0500
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65A22475-C7EA-4A5F-A4EC-F92EF8CC17F8@lca.pw>
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
 <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
 <20200121161533.GT2935@paulmck-ThinkPad-P72>
 <6A6B0325-64C4-4470-91B4-37104CF8DA1A@lca.pw>
 <20200121204606.GZ2935@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 21, 2020, at 3:46 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Tue, Jan 21, 2020 at 02:09:05PM -0500, Qian Cai wrote:
>>> On Jan 21, 2020, at 11:15 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>> On Tue, Jan 21, 2020 at 09:37:13AM -0500, Qian Cai wrote:
>>>>> On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>>>>=20
>>>>> One approach would be to boot with =
rcupdate.rcu_cpu_stall_timeout=3D300,
>>>>> which would allow more time.
>>>>=20
>>>> It works for me if once that warning triggered,  give a bit =
information about adjusting the parameter when debugging options are on =
to suppress the warning due to expected long boot.
>>>=20
>>> Indeed.  300 seconds as shown above is currently the maximum, but
>>> please let me know if it needs to be increased.  This module =
parameter
>>> is writable after boot via sysfs, so maybe that could be part of the
>>> workaround.
>>>=20
>>>>> Longer term, I could suppress this warning during boot when
>>>>> CONFIG_EFI_PGT_DUMP=3Dy, but that sounds quite specific.  =
Alternatively,
>>>>> I could provide a Kconfig option that suppressed this during boot
>>>>> that was selected by whatever long-running boot-time Kconfig =
option
>>>>> needed it.  Yet another approach would be for long-running =
operations
>>>>> like efi_dump_pagetable() to suppress stalls on entry and =
re-enable them
>>>>> upon exit.
>>>>>=20
>>>>> Thoughts?
>>>>=20
>>>> None of the options sounds particularly better for me because there =
could come up with other options may trigger this, memtest comes in =
mind, for example. Then, it is a bit of pain to maintain of unknown.
>>>=20
>>> I was afraid of that.  ;-)
>>>=20
>>> Could you please send me the full dmesg up to that point?  No =
promises,
>>> but it might well be that I can make some broad-spectrum adjustment
>>> within RCU.  Only one way to find out=E2=80=A6
>>=20
>> https://cailca.github.io/files/dmesg.txt
>=20
> Interesting.
>=20
> Does the following (very lightly tested) patch help?

Yes, it works fine.

>=20
> 							Thanx, Paul
>=20
> =
------------------------------------------------------------------------
>=20
> commit fb21277f8f1c5cc40a8d41da2db4b0c499459821
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jan 21 12:30:22 2020 -0800
>=20
>    rcu: Don't flag non-starting GPs before GP kthread is running
>=20
>    Currently rcu_check_gp_start_stall() complains if a grace period =
takes
>    too long to start, where "too long" is roughly one RCU CPU =
stall-warning
>    interval.  This has worked well, but there are some debugging =
Kconfig
>    options (such as CONFIG_EFI_PGT_DUMP=3Dy) that can make booting =
take a
>    very long time, so much so that the stall-warning interval has =
expired
>    before RCU's grace-period kthread has even been spawned.
>=20
>    This commit therefore resets the rcu_state.gp_req_activity and
>    rcu_state.gp_activity timestamps just before the grace-period =
kthread
>    is spawned, and modifies the checks and adds ordering to ensure =
that
>    if rcu_check_gp_start_stall() sees that the grace-period kthread
>    has been spawned, that it will also see the resets applied to the
>    rcu_state.gp_req_activity and rcu_state.gp_activity timestamps.
>=20
>    Reported-by: Qian Cai <cai@lca.pw>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 04718bc..d9d619d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1209,7 +1209,7 @@ static bool rcu_start_this_gp(struct rcu_node =
*rnp_start, struct rcu_data *rdp,
> 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
> 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | =
RCU_GP_FLAG_INIT);
> 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> -	if (!rcu_state.gp_kthread) {
> +	if (!READ_ONCE(rcu_state.gp_kthread)) {
> 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, =
TPS("NoGPkthread"));
> 		goto unlock_out;
> 	}
> @@ -1259,10 +1259,10 @@ static bool rcu_future_gp_cleanup(struct =
rcu_node *rnp)
>  */
> static void rcu_gp_kthread_wake(void)
> {
> -	if ((current =3D=3D rcu_state.gp_kthread &&
> +	if ((current =3D=3D READ_ONCE(rcu_state.gp_kthread) &&
> 	     !in_irq() && !in_serving_softirq()) ||
> 	    !READ_ONCE(rcu_state.gp_flags) ||
> -	    !rcu_state.gp_kthread)
> +	    !READ_ONCE(rcu_state.gp_kthread))
> 		return;
> 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
> 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> @@ -3619,7 +3619,10 @@ static int __init rcu_spawn_gp_kthread(void)
> 	}
> 	rnp =3D rcu_get_root();
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -	rcu_state.gp_kthread =3D t;
> +	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> +	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> +	// Reset .gp_activity and .gp_req_activity before setting =
.gp_kthread.
> +	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
> 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 	wake_up_process(t);
> 	rcu_spawn_nocb_kthreads();
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 476458c..75f6e9f 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -578,6 +578,7 @@ void show_rcu_gp_kthreads(void)
> 	unsigned long jw;
> 	struct rcu_data *rdp;
> 	struct rcu_node *rnp;
> +	struct task_struct *t =3D READ_ONCE(rcu_state.gp_kthread);
>=20
> 	j =3D jiffies;
> 	ja =3D j - READ_ONCE(rcu_state.gp_activity);
> @@ -585,8 +586,7 @@ void show_rcu_gp_kthreads(void)
> 	jw =3D j - READ_ONCE(rcu_state.gp_wake_time);
> 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta =
->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq =
%ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
> 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
> -		rcu_state.gp_state,
> -		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : =
0x1ffffL,
> +		rcu_state.gp_state, t ? t->state : 0x1ffffL,
> 		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
> 		(long)READ_ONCE(rcu_state.gp_seq),
> 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
> @@ -633,7 +633,8 @@ static void rcu_check_gp_start_stall(struct =
rcu_node *rnp, struct rcu_data *rdp,
>=20
> 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
> 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
> -	    		 READ_ONCE(rnp_root->gp_seq_needed)))
> +	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
> +	    !smp_load_acquire(&rcu_state.gp_kthread))
> 		return;
> 	j =3D jiffies; /* Expensive access, and in common case don't get =
here. */
> 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + =
gpssdelay) ||

