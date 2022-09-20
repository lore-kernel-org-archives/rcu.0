Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA1C6FA82
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 17:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITRz5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiITRz4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 13:55:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE46647DE
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 10:55:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d17so2165402qko.13
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=oGx8Ew5rBCzkC/29+QYkFCJyCgfthMBcRcEYluepnCk=;
        b=wPaqEwRARjljxNTOYdx2bZEN4I0m/xnREyaZZueK1LYWLzd9c1neSp/FGxM3wZjS33
         JvCti8ignzFO3X/rQ6nzjGXwdCYuhIf+nEfkzphYL/NVwE6UgqX0nE8IGzJHLxJNu41w
         0y65q8GhcV4wIiqy22PwyW4J6kNTEecsIvPv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oGx8Ew5rBCzkC/29+QYkFCJyCgfthMBcRcEYluepnCk=;
        b=n1rdju7FGX7FVUlNXFIX7rZ3As4cgq8NgXJGn6SYfRArR2DaplsG3gYCBQPCJmJfQC
         Qz0YtBoS73OkicBsgB39nvv9jduDH6gQjEqDMRDsweEyRmxkTm/DDycFXrRP3Az1tMfO
         q0daLOQqoFfLQ27uvi6mgRbJbnHt+ziG0p2BtlmY2mZ0ZRyiHkenqzPyG7QnQqX1YFMI
         CsiCD9+N3HX3DQQuUoYzEWSjYhQTn35XhN195dWtkkB7vRSWLB0CXXx47QJOot7V+uPB
         HFX3Qt0SWRySvXGlsdbyx/10kSvx7jJa+fSLLcuW8H4PYpCnoz/lIBnEyz6B4los1grR
         U2uA==
X-Gm-Message-State: ACrzQf3H9jSuSiKWkKmwNtgteGZ/vCZJvgHRNzUnnFVjX4Ad5fdvGeLv
        2CswCoazJIieqBPTXjKgYkUZWQ==
X-Google-Smtp-Source: AMsMyM7RxavoLkKZzEc00GdSRZq0wbmkDgsrLlSW1K/C9isI/QuLcv3WgIUH6xviyZTArZEvTMaHWA==
X-Received: by 2002:a05:620a:15d4:b0:6ce:1bfc:1d51 with SMTP id o20-20020a05620a15d400b006ce1bfc1d51mr17487082qkm.562.1663696553855;
        Tue, 20 Sep 2022 10:55:53 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id t83-20020a374656000000b006ce9d6e51f4sm260034qka.67.2022.09.20.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 10:55:53 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:55:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <Yyn+qSZiYI02WxOv@google.com>
References: <20220914112251.GV246308@paulmck-ThinkPad-P17-Gen-1>
 <YygjfJkoUzxy9xd/@pc636>
 <20220919131152.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQGPwkTQjxAb5p4OOhJkMA-L93JNTsa-WaXs0Ts7=Oakw@mail.gmail.com>
 <20220919223211.GJ4196@paulmck-ThinkPad-P17-Gen-1>
 <f061b798-e6f6-1523-52c3-12fe7966f809@joelfernandes.org>
 <a2882e80-1723-9004-f67a-cd8332aa701d@joelfernandes.org>
 <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
 <CAEXW_YRsp4HqwAPaDq9VYRptwgdcp7mPJjRH1msE42gzGajBjQ@mail.gmail.com>
 <20220920123208.GL4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920123208.GL4196@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sorry for slightly delayed reply, today was crazy at work.

On Tue, Sep 20, 2022 at 05:32:08AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 20, 2022 at 07:40:01AM -0400, Joel Fernandes wrote:
> > +rcu@vger for archives.
> > On Tue, Sep 20, 2022 at 7:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > On 9/19/2022 7:40 PM, Joel Fernandes wrote:
> > > >> On 9/19/2022 6:32 PM, Paul E. McKenney wrote:
> > > >>> On Mon, Sep 19, 2022 at 05:38:19PM -0400, Joel Fernandes wrote:
> > > >>>> On Mon, Sep 19, 2022 at 9:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>>>>
> > > >>>>> On Mon, Sep 19, 2022 at 10:08:28AM +0200, Uladzislau Rezki wrote:
> > > >>>>>> On Wed, Sep 14, 2022 at 04:22:51AM -0700, Paul E. McKenney wrote:
> > > >>>>>>> On Wed, Sep 14, 2022 at 11:38:32AM +0100, Uladzislau Rezki wrote:
> > > >>>>>>>> On Wed, Sep 14, 2022, 11:23 Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >>>>>>>>
> > > >>>>>>>>> On Wed, Sep 14, 2022 at 02:34:23AM -0700, Paul E. McKenney wrote:
> > > >>>>>>>>>> Agreed.  There could be a list of functions in call_rcu() that are
> > > >>>>>>>>>> treated specially.
> > > >>>>>>>>>>
> > > >>>>>>>>>> But please be careful.  Maintainers of a given function might have
> > > >>>>>>>>>> something to say about that function being added to that list.  ;-)
> > > >>>>>>>>>>
> > > >>>>>>>>>> But one big advantage of this is that the list of functions could be
> > > >>>>>>>>>> private to ChromeOS and/or Android.  Maintainers might still be annoyed
> > > >>>>>>>>>> about bugs sent to them whose root cause was addition of their function
> > > >>>>>>>>>> to the call_rcu() list, though.  ;-)
> > > >>>>>>>>>
> > > >>>>>>>>> Are you sure you want this feature to be usable and debuggable by Android
> > > >>>>>>>>> only?
> > > >>>>>>>>>
> > > >>>>>>>> Adding on top of Frederic sentence. Sorry for that 😀
> > > >>>>>>>>
> > > >>>>>>>> Do you mean to have the function names internally to be able to detect what
> > > >>>>>>>> is called and based on that func list place them in a lazy track?
> > > >>>>>>>
> > > >>>>>>> Yes, if needed.  But in addition to using call_rcu_lazy() where the
> > > >>>>>>> callback functions' maintainers are good with it.
> > > >>>>>>>
> > > >>>>>>> Of course, if all relevant maintainers are OK with all the callback
> > > >>>>>>> functions being passed to call_rcu_lazy(), then their is no need for
> > > >>>>>>> the internal switching.
> > > >>>>>>>
> > > >>>>>> Then we would need map function names internally. I think what we got as
> > > >>>>>> a feedback from the conference session is it makes sense to improve the
> > > >>>>>> batching in general of call_rcu(). Doing it we will improve and cover
> > > >>>>>> all current users. So we do not need to distinguish lazy variant and a
> > > >>>>>> normal one from each other. Also we do not need to explain people the
> > > >>>>>> difference and switch to _lazy() across the kernel code. As we also
> > > >>>>>> discussed one regular non-lazy call will revert everything back to a
> > > >>>>>> problem that is in question.
> > > >>>>>>
> > > >>>>>> As Thomas said, look at it as: delay of invocation and if needed in
> > > >>>>>> corner case do kind of expedited or sync support. For example call_rcu_sync().
> > > >>>>>>
> > > >>>>>> It is not up to me but... I just share my view :)
> > > >>>>>
> > > >>>>> Me, I am a bit pessimistic about the probability of us getting away with
> > > >>>>> making the file-close RCU callback be lazy.
> > > >>>>>
> > > >>>>> After all, this thing is used across all filesystems along with a great
> > > >>>>> many things that are not filesystems.  It doesn't really matter whether
> > > >>>>> this laziness comes from a conversion to call_rcu_lazy() as in Joel's most
> > > >>>>> recent patch, lack of a conversion to call_rcu_expedited() as in Thomas
> > > >>>>> Gleixner's suggestion, or a mapping within call_rcu() as I suggested.
> > > >>>>>
> > > >>>>> Don't get me wrong, it would be great if this callback really can be
> > > >>>>> always lazy, non-expedited, or whatever, but we should not take this
> > > >>>>> for granted.
> > > >>>>
> > > >>>> Are you saying we should not make call_rcu() default-lazy for
> > > >>>> everyone? According to Thomas, anyone expecting call_rcu() to finish
> > > >>>> in any reasonable amount of time is a bug, and that usecase needs to
> > > >>>> be fixed to use synchronize_rcu(). Are we saying now that that's not
> > > >>>> our direction?
> > > >>>
> > > >>> I am saying that Thomas can sometimes get quite enthusiastic about
> > > >>> a particular direction.  Plus I strongly suspect that Thomas has not
> > > >>> actually reviewed all of the RCU callbacks.
> > > >>>
> > > >>> Of course, I agree that it won't hurt to try out Thomas's suggestion,
> > > >>> which is why I did not object at the time.  But we should be fully
> > > >>> prepared for it to blow up in our faces.  ;-)
> > > >>
> > > >> Makes sense, thanks for clarifying. My impression was he does expect some pain
> > > >> in the short-term but the pain is worth not introduction a new opt-in API.
> > > >>
> > > >> I am wondering if putting it behind a CONFIG option will delay the pain too
> > > >> much. Thoughts? I am assuming that we want the CONFIG to turn it off by default.
> > > >
> > > > I tried a poor man's version of Thomas's idea by doing
> > > > jiffies_till_first_fqs=1000 and rcu.rcu_expedited=1 boot parameters. Of course
> > > > this just for trying has no regard for memory pressure and such so it is in the
> > > > 'do not try at home' category.
> > > >
> > > > Then I tried jiffies_till_first_fqs=128 and compare before/after kernel logs.
> > > >
> > > > These are on ChromeOS hardware (5.19-rc4 kernel)
> > > > For jiffies_till_first_fqs=1000 Everything is fine until this point:
> > > >     8.383646] Freeing unused kernel image (initmem) memory: 1676K
> > > >    11.378880] Write protecting the kernel read-only data: 28672k
> > > >
> > > > I do not see this 3 second delay with jiffies_till_first_fqs=128.
> > > >     8.411866] Freeing unused kernel image (initmem) memory: 1676K
> > > >     8.656701] Write protecting the kernel read-only data: 28672k
> > >
> > > At least this could be because of the rodata write protection stuff calling
> > > rcu_barrier():
> > >
> > > From init/main.c
> > >
> > > #ifdef CONFIG_STRICT_KERNEL_RWX
> > > static void mark_readonly(void)
> > > {
> > >         if (rodata_enabled) {
> > >                 /*
> > >                  * load_module() results in W+X mappings, which are cleaned
> > >                  * up with call_rcu().  Let's make sure that queued work is
> > >                  * flushed so that we don't hit false positives looking for
> > >                  * insecure pages which are W+X.
> > >                  */
> > >                 rcu_barrier();
> > >                 mark_rodata_ro();
> > >                 rodata_test();
> > >         } else
> > >                 pr_info("Kernel memory protection disabled.\n");
> > > }
> > >
> > >
> > > I think rcu_barrier() does not play well with jiffiest_till_first_fqs (probably
> > > because of the missing wake ups I found in the existing code, I should try that
> > > patch on this test..).
> > >
> > > Is it expected that a sleep involving jiffies_till_first_fqs does not get
> > > disturbed due to rcu_barrier() ? That seems like a bug to me. At least for
> > > !NOCB, I don't see any call the rcu_gp_kthread_wake() from rcu_barrier()!
> 
> Another approach is to take your current stack of patches, but only those
> to RCU, and then as Thomas suggests, make call_rcu() behave lazily and
> make a call_rcu_expedited() that retains the current behavior.  Keep the
> current grace-period timings.

Yes these sound good. But one issue is, we do not know all the cases that
needed call_rcu_expedited(). There is the per-cpu refcount which needs it,
but I'm not aware of any others. If you take the patches, can we add convert
to call_rcu_expedited() as regressions happen?

> Then make synchronize_rcu() and friends use call_rcu_expedited() and see
> if you can get away with only a small number of call_rcu_expedited()
> "upgrades".

Right. It is a bit of a chicken-and-egg problem, if we have to whitelist
everything, then we have to blacklist as we go. If we blacklist everything,
then we may miss whitelisting something.

Thoughts?

Meanwhile just to clarify- I am very much invested in seeing the current
stack of patches merged soon give or take the _expedited() conversions,
however I did the above jiffies_till_first experiments in the hopes they
would show the ones that need such conversion quickly.

thanks,

 - Joel

