Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D4C38A02
	for <rcu@archiver.kernel.org>; Mon, 31 Oct 2022 02:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJaCKS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaCKQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Oct 2022 22:10:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800A9FCD
        for <rcu@vger.kernel.org>; Sun, 30 Oct 2022 19:10:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso14636037pjz.4
        for <rcu@vger.kernel.org>; Sun, 30 Oct 2022 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp85cGjgnCCgjiOTtcpBAYGzT1wXfW2tHmYfoS1oBHo=;
        b=GdnysQzMsR20RPcRUc4Gu/78+JUdLfT0dxI72agCGvcH9N9pwih9NpM9esbhSEmipz
         Fi6fjjDupj/ssIPjNdDZzl7d2Ykm70aLpT4hEhQ4XG3XdYy01yUPeQHTJakNJuK39tai
         d2e06q1aS+Q36hKh5l//NG3FQtI/k30OpZX5tyiOUBpCSlOOFBzMbRAbwEj+3KXnhM6Y
         e0GCYYLpWmG5MI3ehhfC0vwTSul6llV845YemEs7zlwGx8PITLgDbUON/4H9Q2tZJKCy
         GpkEjIh6gidGQ5oXv18y89hi40FHLAIiqG1OEjL9WwEKKpfqi1AqN53KhfKzgkhbJJDF
         06kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp85cGjgnCCgjiOTtcpBAYGzT1wXfW2tHmYfoS1oBHo=;
        b=LUtaL7/Ucs10x4KWG7cx9ZV7QjIiUh6tdYTPwdBf36FeZpQBbcM5hIi5XVZh5Wk/Oy
         56XWRQUBatqJTHCATvYqGBSHBEg4f1bpBGz8TD1FZt3056/8hQDvp3+n5DQFZofut3FQ
         BRRpzJCKay+wQw/PeeSMn7i+oiQBcZm8RNaI6EadLgw7m2ds+25H/0FHZR9e9iYTRzuJ
         cmk6VXMJRD9UF371FnHgeH2liNyzFGdpZxc02SgENDTAf8Y4NC6bPeSELdnefc6R7qYN
         SHKZTCiFmVZoUpUi5w3chUxCcyIlCFFOOqIKbUMP978WBn6MijAjGgZNYWuMJrAcjtOg
         KYTA==
X-Gm-Message-State: ACrzQf35jq7xiXqD63hiMJo9EztxdtnFa1fUXD/DoovJBc/9IDdK2/0L
        vIWBzjeHMaZ2z4XV7cSMNQ==
X-Google-Smtp-Source: AMsMyM4tPveRt8NX40IoT/xRlsKB80CoKpqWPIl+thoBzr30CoGIQ/G4lF+FInndTzBPhj8hUBeszw==
X-Received: by 2002:a17:90b:f06:b0:212:cb07:fb82 with SMTP id br6-20020a17090b0f0600b00212cb07fb82mr28770357pjb.221.1667182215344;
        Sun, 30 Oct 2022 19:10:15 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h75-20020a62834e000000b0056b932f3280sm3246657pfe.103.2022.10.30.19.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 19:10:14 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:10:05 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <Y18ufYcpSnnHxjxB@piliu.users.ipa.redhat.com>
References: <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTtNetv7v_Law=abPtngC8Gv6OGcGz9M_wWMxz_GAEWDUQ@mail.gmail.com>
 <20221027181346.GD5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027181346.GD5600@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 27, 2022 at 11:13:46AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 10, 2022 at 09:42:07AM +0800, Pingfan Liu wrote:
> > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Oct 02, 2022 at 09:29:59PM +0800, Pingfan Liu wrote:
> > [...]
> > 
> > > >
> > > > Quote from TREE04.43 console.log
> > > > "
> > > > ...
> > > > [162003.262292] rcu-torture: rtc: 0000000000000000 VER: 4371112 tfle:
> > > > 0 rta: 4371112 rtaf: 0 rtf: 4371103 rtmbe: 0 rtmbkf: 0/1801158 rtbe: 0
> > > > rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 206435148 onoff:
> > > > 189317/189317:189321/189321 1,1877:1,3248 25561605:45469848 (HZ=1000)
> > > > barrier: 769073/769073:0 read-exits: 185104 nocb-toggles: 0:0
> > > > [162003.264714] rcu-torture: Reader Pipe:  338936620402 7452360 0 0 0
> > > > 0 0 0 0 0 0
> > > > [162003.265336] rcu-torture: Reader Batch:  338929088717 14984045 0 0
> > > > 0 0 0 0 0 0 0
> > > > [162003.265967] rcu-torture: Free-Block Circulation:  4371111 4371111
> > > > 4371110 4371109 4371108 4371107 4371106 4371105 4371104 4371103 0
> > > > [162003.266980] rcu-torture: rcu_torture_stats is stopping
> > > > [162003.267450] rcu_torture_cleanup: Invoking rcu_barrier+0x0/0x3b0().
> > > > [162003.278480] Stack Depot allocating hash table of 32768 entries with kvcalloc
> > > > [162003.279947] mem_dump_obj() slab test: rcu_torture_stats =
> > > > 0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffff965e01a58000, &z
> > > > = ffffffffa676d9a0
> > > > [162003.281079] mem_dump_obj(ZERO_SIZE_PTR): zero-size pointer
> > > > [162003.281563] mem_dump_obj(NULL): NULL pointer
> > > > [162003.281935] mem_dump_obj(ffffa0aa0035feb8): 4-page vmalloc region
> > > > starting at 0xffffa0aa0035c000 allocated at kernel_clone+0x92/0x3b0
> > > > [162003.283044] mem_dump_obj(ffff965e01a58000): slab rcuscale start
> > > > ffff965e01a58000 pointer offset 0 allocated at
> > > > rcu_torture_cleanup+0x432/0x4e0
> > > > [162003.284138]     kmem_cache_alloc+0x19d/0x1b0
> > > > [162003.284522]     rcu_torture_cleanup+0x432/0x4e0
> > > > [162003.284918]     torture_shutdown+0xce/0x1c0
> > > > [162003.285285]     kthread+0xb7/0xe0
> > > > [162003.285587]     ret_from_fork+0x22/0x30
> > > > [162003.285926] mem_dump_obj(ffff965e01a58008): slab rcuscale start
> > > > ffff965e01a58000 pointer offset 8 allocated at
> > > > rcu_torture_cleanup+0x432/0x4e0
> > > > [162003.287045]     kmem_cache_alloc+0x19d/0x1b0
> > > > [162003.287436]     rcu_torture_cleanup+0x432/0x4e0
> > > > [162003.287835]     torture_shutdown+0xce/0x1c0
> > > > [162003.288202]     kthread+0xb7/0xe0
> > > > [162003.288510]     ret_from_fork+0x22/0x30
> > > > [162003.288848] mem_dump_obj(ffffffffa676d9a0): non-slab/vmalloc memory
> > > > [162003.289426] mem_dump_obj() kmalloc test: rcu_torture_stats =
> > > > 0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffff965e144447e0
> > > > [162003.290421] mem_dump_obj(kmalloc ffff965e144447e0): slab
> > > > kmalloc-16 start ffff965e144447e0 pointer offset 0 size 16
> > > > [162003.291316] mem_dump_obj(kmalloc ffff965e144447e8): slab
> > > > kmalloc-16 start ffff965e144447e0 pointer offset 8 size 16
> > > > [162003.292211] mem_dump_obj() vmalloc test: rcu_torture_stats =
> > > > 0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffffa0aa0002d000
> > > > [162003.293186] mem_dump_obj(vmalloc ffffa0aa0002d000): 1-page vmalloc
> > > > region starting at 0xffffa0aa0002d000 allocated at
> > > > rcu_torture_cleanup.cold+0x287/0x3ef
> > > > [162003.294372] mem_dump_obj(vmalloc ffffa0aa0002d008): 1-page vmalloc
> > > > region starting at 0xffffa0aa0002d000 allocated at
> > > > rcu_torture_cleanup.cold+0x287/0x3ef
> > > > [162003.295548] rcu-torture: rtc: 0000000000000000 VER: 4371112 tfle:
> > > > 0 rta: 4371112 rtaf: 0 rtf: 4371103 rtmbe: 0 rtmbkf: 0/1801158 rtbe: 0
> > > > rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 206435148 onoff:
> > > > 189317/189317:189321/189321 1,1877:1,3248 25561605:45469848 (HZ=1000)
> > > > barrier: 769073/769073:0 read-exits: 185104 nocb-toggles: 0:0
> > > > [162003.297956] rcu-torture: Reader Pipe:  338936620402 7452360 0 0 0
> > > > 0 0 0 0 0 0
> > > > [162003.298578] rcu-torture: Reader Batch:  338929088717 14984045 0 0
> > > > 0 0 0 0 0 0 0
> > > > [162003.299208] rcu-torture: Free-Block Circulation:  4371111 4371111
> > > > 4371110 4371109 4371108 4371107 4371106 4371105 4371104 4371103 0
> > > > [162003.300220] rcu-torture:--- End of test: SUCCESS: nreaders=7
> > > > nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1
> > > > shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0
> > > > fqs_stutter=3 test_boost=1/0 test_boost_interval=7
> > > > test_boost_duration=4 shutdown_secs=162000 stall_cpu=0
> > > > stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0
> > > > n_barrier_cbs=4 onoff_interval=200 onoff_holdoff=30 read_exit_delay=13
> > > > read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
> > > > [162003.304162] i2c i2c-0: shutdown
> > > > [162003.304461] alarmtimer alarmtimer.0.auto: shutdown
> > > > [162003.304878] psmouse serio1: shutdown
> > > > ...
> > > > "
> > >
> > > Huh.  Shutdown writer stall on the first one, but I am not seeing the
> > > but in the second one.  Was the "Call Trace" located somewhere else in
> > > the console.log file?
> > >
> > > I have not seen the shutdown writer stall lately, but such stalls have
> > > flagged many sorts of bugs for me to fix in the past.
> > >
> > >
> > > So maybe there is yet another bug that my testing is for whatever reason
> > > not seeing.
> > 
> > Sorry to reply late, I just came back from a long holiday.
> 
> Given my delay, I guess that I cannot complain...
> 

Thanks for insight to the log. I am a little astray in the whole torture
test. I will pay more time to study it.

> > The attachment is the complete log of TREE04.43.
> 
> This happens because rcutorture hit OOM while doing RCU callback flood
> testing.  This -might- be related to the changes, for example if timers
> slowed down, thus slowing down RCU grace periods, thus allowing the
> kthread doing the flooding exhaust memory.
> 
> Grace periods are progressing in the histogram:
> 
> [12077.630343] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 1321 jiffies): 1s/10: 75043:17 2s/10: 137085:35 3s/10: 143871:14 4s/10: 66038:26 5s/10: 51754:18 6s/10: 67000:16 7s/10: 54155:17 8s/10: 56749:23 9s/10: 120850:8 10s/10: 87789:17 11s/10: 111123:32 12s/10: 136322:50 13s/10: 108813:33 14s/10: 138489:1
> [12077.632824] rcu: rcu_fwd_progress_check: GP age 17 jiffies
> 
> And there is this:
> 
> [12077.644478] rcu: RCU callbacks invoked since boot: 102942584
> [12077.644974] rcu: rcu_fwd_progress_check: callbacks 0: 45 4: 7973717
> [12077.695770] rcutorture_oom_notify: Freed 592481 RCU callbacks.
> 
> So another question is "how much memory was available to rcutorture?"
> 
> Less than 512MB could explain this.
> 

Each machine has 262144 MB RAM, and runs 32 TREE04 instance. So each
instance has nearly 8192 MB RAM. (I do not run any other load)


Thanks,

	Pingfan

> (I do see this from time to time, but on single-CPU TREE09 runs.)
> 
> 							Thanx, Paul
