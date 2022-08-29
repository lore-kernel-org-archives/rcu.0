Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A9ECAAD5
	for <rcu@archiver.kernel.org>; Mon, 29 Aug 2022 13:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH2Nk7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiH2Nkv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 Aug 2022 09:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394A7696A;
        Mon, 29 Aug 2022 06:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A697260E2D;
        Mon, 29 Aug 2022 13:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8320DC433D6;
        Mon, 29 Aug 2022 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780449;
        bh=xv38Z6v2n0K90c6gGumVR9aB5fi61GGLKWtszP09R1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBo/LjLe6wSHY95tDt85mxAz+iCyQu+l5tvBzWIod+9JxgupGYr92IefdZN2Z89bN
         7WQLALVjtSLLDzn1OOFO8GC2QgReJ8oiZw9Myra2Qfy2iXRnZP5+R2DmFyw12aG54v
         j2GHoQ1OPqVk6Few7Qbmq7Hc3KWToC7KHF28kAXqw1Z14QN4J2uOnXa/BmpD7tGNCY
         aEh7cz4ofwYY5KGZ40zm7aYSHkET50qTT/VsKeBqvPiC8loBoAuAZYaGkrFCiuCcgy
         wDIIZDa8qAuCVUxTVXNwIQbENWJsr3usj8TDG9yNfVOehwJSaYplWGb8UG/ngecu1r
         w5//ykycgqhJQ==
Date:   Mon, 29 Aug 2022 15:40:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220829134045.GA54589@lothringen>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
> and rcuscale tests.
> 
> Fixes on top of v3:
> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
> - Fixed trace_rcu_callback tracepoint
> 
> I tested power previously [1], I am in the process of testing power again but I
> wanted share my latest code as others who are testing power as well could use
> the above fixes.

Your patch is very likely to be _generally_ useful and therefore,
the more I look into this, the more I wonder if it is a good idea to rely on
bypass at all, let alone NOCB. Of course in the long term the goal is to have
bypass working without NOCB but why even bothering implementing it for nocb
in the first place?

Several highlights:

1) NOCB is most often needed for nohz_full and the latter has terrible power
management. The CPU 0 is active all the time there.

2) NOCB without nohz_full has extremely rare usecase (RT niche:
https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
)

2) NOCB implies performance issues.

3) We are mixing up two very different things in a single list of callbacks:
   lazy callbacks and flooding callbacks, as a result we are adding lots of
   off-topic corner cases all around:
     * a seperate lazy len field to struct rcu_cblist whose purpose is much more
       general than just bypass/lazy
     * "lazy" specialized parameters to general purpose cblist management
       functions

4) This is further complexifying bypass core code, nocb timer management, core
   nocb group management, all of which being already very complicated.

5) The !NOCB implementation is going to be very different

Ok I can admit one counter argument in favour of using NO_CB:

-1) The scheduler can benefit from a wake CPU to run the callbacks on behalf of a bunch
of idle CPUs, instead of waking up that bunch of CPUs. But still we are dealing
with callbacks that can actually wait...


So here is a proposal: how about forgetting NOCB for now and instead add a new
RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
Then ignore that segment until some timer expiry has been met or the CPU is
known to be busy? Probably some tiny bits need to be tweaked in segcblist
management functions but probably not that much. And also make sure that entrain()
queues to RCU_LAZY_TAIL.

Then the only difference in the case of NOCB is that we add a new timer to the
nocb group leader instead of a local timer in !NOCB.

Now of course I'm certainly overlooking obvious things as always :)

Thanks.
