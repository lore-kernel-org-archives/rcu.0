Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37883C77B73
	for <rcu@archiver.kernel.org>; Wed, 24 May 2023 12:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjEXMCQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 May 2023 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEXMCP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 May 2023 08:02:15 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 05:02:14 PDT
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [IPv6:2001:41d0:203:375::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FA97
        for <rcu@vger.kernel.org>; Wed, 24 May 2023 05:02:14 -0700 (PDT)
Message-ID: <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684929400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMsexn7FypO2MxTw7kOkZKMP6/q4BmJjDQCpRviZwTk=;
        b=WiHpg5RNA4GTwK2SDkHLvlaHzfo3/HpO34N4XoPdsW0f4IrTrk2Utap9fkZOHfoZnzWEUM
        0CNPosbjasx5hfvCkRzmQcfaYfYXeLk2MywMuAOKAjaRsOv+4Vn4L3rjgUgWuewCVawufe
        gIoLMAnY89tKHEm9SxQWeeC/G6kpSrM=
Date:   Wed, 24 May 2023 19:56:30 +0800
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

With the following changes, ops/s can return to previous levels:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index db2ed6e08f67..90f541b07cd1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -763,7 +763,7 @@ void unregister_shrinker(struct shrinker *shrinker)
         debugfs_entry = shrinker_debugfs_remove(shrinker);
         up_write(&shrinker_rwsem);

-       synchronize_srcu(&shrinker_srcu);
+       synchronize_srcu_expedited(&shrinker_srcu);

         debugfs_remove_recursive(debugfs_entry);

stress-ng: info:  [13159] dispatching hogs: 9 ramfs
stress-ng: info:  [13159] stressor       bogo ops real time  usr time 
sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [13159]                           (secs)    (secs) 
(secs)   (real time) (usr+sys time)
stress-ng: info:  [13159] ramfs            710062     60.00      9.63 
157.26     11834.18        4254.75
stress-ng: info:  [13159] for a 60.00s run time:
stress-ng: info:  [13159]    1920.14s available CPU time
stress-ng: info:  [13159]       9.62s user time   (  0.50%)
stress-ng: info:  [13159]     157.26s system time (  8.19%)
stress-ng: info:  [13159]     166.88s total time  (  8.69%)
stress-ng: info:  [13159] load average: 9.49 4.02 1.65
stress-ng: info:  [13159] successful run completed in 60.00s (1 min, 
0.00 secs)

Can we make synchronize_srcu() call synchronize_srcu_expedited() when no
one is in the read critical section?

> 

-- 
Thanks,
Qi
