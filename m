Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D991C7EE2C
	for <rcu@archiver.kernel.org>; Wed, 24 May 2023 11:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEXLXL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 May 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjEXLXK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 May 2023 07:23:10 -0400
X-Greylist: delayed 885 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 04:23:08 PDT
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36914135
        for <rcu@vger.kernel.org>; Wed, 24 May 2023 04:23:07 -0700 (PDT)
Message-ID: <2c5df9e0-9b1f-89eb-4d64-c5091ead9cf0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684927386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7uIYMMBsG2+gFwRyUinbXHkYOIikxEdGr36MvRUJ8c=;
        b=UDiOa/81mudJk0eXr2RQY2l6PUDl6gutYQUUOBdWfw4+15hm55V38MmdVeo8ZBbuswPAFY
        1iSSHBTD3py36UxZcDvDq/qD2DEAJoyPeXpgy5NsEneGuN2zjBbbI9o1IVf8kR2YwibCRo
        20qMn8Ci3rj0h3HJsM6Kqt1Dhq1pZaM=
Date:   Wed, 24 May 2023 19:22:55 +0800
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
To:     RCU <rcu@vger.kernel.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kirill Tkhai <tkhai@ya.ru>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Yujie Liu <yujie.liu@intel.com>
References: <202305230837.db2c233f-yujie.liu@intel.com>
 <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
 <ZG29ULGNJdErnatI@yujie-X299>
 <896bbb09-d400-ec73-ba3a-b64c6e9bbe46@linux.dev>
 <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
In-Reply-To: <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 2023/5/24 19:08, Qi Zheng wrote:
> 

[...]

> 
> Well, I just ran the following command and reproduced the result:
> 
> stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
> 
> 1) with commit 42c9db3970483:
> 
> stress-ng: info:  [11023] setting to a 60 second run per stressor
> stress-ng: info:  [11023] dispatching hogs: 9 ramfs
> stress-ng: info:  [11023] stressor       bogo ops real time  usr time 
> sys time   bogo ops/s     bogo ops/s
> stress-ng: info:  [11023]                           (secs)    (secs) 
> (secs)   (real time) (usr+sys time)
> stress-ng: info:  [11023] ramfs            774966     60.00     10.18 
> 169.45     12915.89        4314.26
> stress-ng: info:  [11023] for a 60.00s run time:
> stress-ng: info:  [11023]    1920.11s available CPU time
> stress-ng: info:  [11023]      10.18s user time   (  0.53%)
> stress-ng: info:  [11023]     169.44s system time (  8.82%)
> stress-ng: info:  [11023]     179.62s total time  (  9.35%)
> stress-ng: info:  [11023] load average: 8.99 2.69 0.93
> stress-ng: info:  [11023] successful run completed in 60.00s (1 min, 
> 0.00 secs)
> 
> 2) with commit f95bdb700bc6b:
> 
> stress-ng: info:  [37676] dispatching hogs: 9 ramfs
> stress-ng: info:  [37676] stressor       bogo ops real time  usr time 
> sys time   bogo ops/s     bogo ops/s
> stress-ng: info:  [37676]                           (secs)    (secs) 
> (secs)   (real time) (usr+sys time)
> stress-ng: info:  [37676] ramfs            168673     60.00      1.61 
>   39.66      2811.08        4087.47
> stress-ng: info:  [37676] for a 60.10s run time:
> stress-ng: info:  [37676]    1923.36s available CPU time
> stress-ng: info:  [37676]       1.60s user time   (  0.08%)
> stress-ng: info:  [37676]      39.66s system time (  2.06%)
> stress-ng: info:  [37676]      41.26s total time  (  2.15%)
> stress-ng: info:  [37676] load average: 7.69 3.63 2.36
> stress-ng: info:  [37676] successful run completed in 60.10s (1 min, 
> 0.10 secs)
> 
> The bogo ops/s (real time) did drop significantly.
> 
> And the memory reclaimation was not triggered in the whole process. so
> theoretically no one is in the read critical section of shrinker_srcu.
> 
> Then I found that some stress-ng-ramfs processes were in
> TASK_UNINTERRUPTIBLE state for a long time:
> 
> root       42313  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42314  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42315  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42316  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42317  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42318  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42319  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42320  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42321  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42322  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42323  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42324  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42325  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42326  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
> stress-ng-ramfs [run]
> root       42327  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42328  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42329  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> root       42330  7.9  0.0  69592  1556 pts/0    D    19:00   0:02 
> stress-ng-ramfs [run]
> 
> Their call stack is as follows:
> 
> cat /proc/42330/stack
> 
> [<0>] __synchronize_srcu.part.21+0x83/0xb0
> [<0>] unregister_shrinker+0x85/0xb0
> [<0>] deactivate_locked_super+0x27/0x70
> [<0>] cleanup_mnt+0xb8/0x140
> [<0>] task_work_run+0x65/0x90
> [<0>] exit_to_user_mode_prepare+0x1ba/0x1c0
> [<0>] syscall_exit_to_user_mode+0x1b/0x40
> [<0>] do_syscall_64+0x44/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> + RCU folks, Is this result as expected? I would have thought that
> synchronize_srcu() should return quickly if no one is in the read
> critical section. :(
> 

I received the message:
	BOUNCE rcu@vger.kernel.org: Message too long (>100000 chars)

So add RCU folks again.

-- 
Thanks,
Qi
