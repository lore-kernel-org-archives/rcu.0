Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F02C433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A710461184
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhDORPd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233074AbhDORP3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:15:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60FA86101B;
        Thu, 15 Apr 2021 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618506905;
        bh=cmo/l8FgpCa5H2zYqgdBfT2/sgt//4LTAOcdqDuhoo0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vKmsuB0ga8RH+8ZpsyfhWJ3fFqLtL63JYQPSQHfuOPIasRpJQK9yyuhg33AGwxroX
         JSwUU4DRUTmqLM+zAZRiuu2+2mG0a0ikuOcvT8padsp8GiNCCpzevrf3YQnNxcnIsM
         MJrdXaU0wSwMtxuqHoqtUTYMEvYYFzG4VX1ryNuGzpX5axgxod5zY/kMfHCxbYRaof
         9kkJ2RzjLyJB25Ya4+Q4H988UOJ/5TINZYplYQkVC6ckBLDv4G8MN0YbFBj6L9stZ1
         20WBUiKHQlNe0u3pUMe2lxU5pHeNcrJKN6p3KMnzjIVESla5EM9KKjBYZf59E4PAYo
         StX76oWIy+b0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F38C45C00F4; Thu, 15 Apr 2021 10:15:04 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:15:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption
 code path
Message-ID: <20210415171504.GB4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
 <aa5ea94b-fe0e-bc0e-5a8c-627a206e3efc@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa5ea94b-fe0e-bc0e-5a8c-627a206e3efc@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 16, 2021 at 01:01:17AM +0800, Xu, Yanfei wrote:
> 
> 
> On 4/16/21 12:18 AM, Xu, Yanfei wrote:
> > 
> > 
> > On 4/15/21 11:43 PM, Paul E. McKenney wrote:
> > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > 
> > > On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
> > > > Hi experts,
> > > > 
> > > > I am learning rcu mechanism and its codes. When looking at the
> > > > rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
> > > > operation in non-preemption code path. And it has been a long
> > > > time. I can't
> > > > understand why we need it? Is there some thing I missed? If not, can we
> > > > remove the unnecessary operation like blow?
> > > 
> > > Good point, you are right that preemption is disabled anyway in that
> > > block
> > > of code.  However, preempt_disable() and preempt_enable() also
> > > prevent the
> > > compiler from moving that READ_ONCE() around.  So my question to you is
> > > whether it is safe to remove those statements entirely or whether they
> > > should instead be replaced by barrier() or similar.
> > 
> > Thanks for your reply! :)
> > 
> > Yes, preempt_disable() and preempt_enable() defined in !preemption are
> > barrier(). barrier can prevent from reordering that READ_ONCE(), but
> > base on my current understanding, volatile in READ_ONCE can also tell
> > the compiler not to reorder it. So, I think it's safe?
> > 
> > Best regards,
> > Yanfei
> 
> Hi Paul,
> I objdump the function rcu_blocking_is_gp():
> 
> after dropping the barrier():
> ffffffff81107c50 <rcu_blocking_is_gp>:
> ffffffff81107c50:       e8 7b 2a f5 ff          callq  ffffffff8105a6d0
> <__fentry__>
> ffffffff81107c55:       8b 05 41 fe 7c 01       mov 0x17cfe41(%rip),%eax
> # ffffffff828d7a9c <rcu_state+0x221c>
> ffffffff81107c5b:       55                      push   %rbp
> ffffffff81107c5c:       48 89 e5                mov    %rsp,%rbp
> ffffffff81107c5f:       5d                      pop    %rbp
> ffffffff81107c60:       83 f8 01                cmp    $0x1,%eax
> ffffffff81107c63:       0f 9e c0                setle  %al
> ffffffff81107c66:       0f b6 c0                movzbl %al,%eax
> ffffffff81107c69:       c3                      retq
> ffffffff81107c6a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> 
> the original codes:
> ffffffff81107ba0 <rcu_blocking_is_gp>:
> ffffffff81107ba0:       e8 2b 2b f5 ff          callq  ffffffff8105a6d0
> <__fentry__>
> ffffffff81107ba5:       55                      push   %rbp
> ffffffff81107ba6:       48 89 e5                mov    %rsp,%rbp
> ffffffff81107ba9:       8b 05 ed fe 7c 01       mov 0x17cfeed(%rip),%eax
> # ffffffff828d7a9c <rcu_state+0x221c>
> ffffffff81107baf:       83 f8 01                cmp    $0x1,%eax
> ffffffff81107bb2:       5d                      pop    %rbp
> ffffffff81107bb3:       0f 9e c0                setle  %al
> ffffffff81107bb6:       0f b6 c0                movzbl %al,%eax
> ffffffff81107bb9:       c3                      retq
> ffffffff81107bba:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> 
> umm... It did been reordered by compiler after dropping the barrier(),
> however, I think the result will not be effected. Right?

Indeed, the compiler is free to reorder volatile accesses with
non-volatile accesses.

The result might not be affected by your compiler using your particular
settings for optimizations, but is that true for all optimization settings
for all compilers, both now and in the future?

							Thanx, Paul

> Best regards,
> Yanfei
> 
> > 
> > > 
> > >                                                          Thanx, Paul
> > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index da6f5213fb74..c6d95a00715e 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
> > > >          if (IS_ENABLED(CONFIG_PREEMPTION))
> > > >                  return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> > > >          might_sleep();  /* Check for RCU read-side critical section. */
> > > > -       preempt_disable();
> > > >          /*
> > > >           * If the rcu_state.n_online_cpus counter is equal to one,
> > > >           * there is only one CPU, and that CPU sees all prior accesses
> > > > @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
> > > >           * Those memory barriers are provided by CPU-hotplug code.
> > > >           */
> > > >          ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
> > > > -       preempt_enable();
> > > >          return ret;
> > > >   }
> > > > 
> > > > 
> > > > 
> > > > Best regards,
> > > > Yanfei
