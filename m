Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8A1C6FA8B
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiITLkP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITLkO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 07:40:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D35263F32
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 04:40:13 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n81so1965561iod.6
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=81VUIIlBj5Eh1CPs7XzqAW6MfmLfK0x/wiszHyy9Bfs=;
        b=H8NgjWQMcFMJkZ8BusZHTU09+V6O8UFG6az1ZtKkkLfz5UzNjeM4sxfdz6oeZnobCW
         Y/I3le4vv174LYrJ24K4TX0cQ1zp0Vx7hGcRlsde7qDPK0xsME2HhUo8xKUpXQKZAXja
         gnaLduTW7YLOQhim9jPagazbrEOtcxC/xFzjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=81VUIIlBj5Eh1CPs7XzqAW6MfmLfK0x/wiszHyy9Bfs=;
        b=D2wMrtOm7NnDTZGWf7NJBuy91QC7oCPJgLmSItROtEM5jcympsO1WkSImi2F8y+wPS
         Sg8yhZI2sO0tdVI7dLFtv/UukARRNkzK+PDxSDsXbw6M5H6d9xBCPNG6256IxjT3AvVp
         go+jMUq6JqXCDK66An+uCF8kZz6MbqooT7F9ignNkza02ClVC5hkzBa5KQPDbnSPq1RA
         52pyGXxj/Zghsdz4dYyMzSnrGrSNqU8YbgP710+yvBEGe4tDysw+fIVRlEUY3/N74H51
         k0u3NP3Hlg8ChnuBMDlOh6KkFeBo4daONQyubJb57qvho7jjQIgTCaB6NQwOHjWTgfar
         Bn2g==
X-Gm-Message-State: ACrzQf0qNH74DlrLjGQ0UFlQawyHwMd3RrG/RQhjD/3rvcOA6rm2+Qtm
        kz0fGnZfx9nLon9SKYHIqBUVaJ7rdZ0MVwVTmyO4vg==
X-Google-Smtp-Source: AMsMyM7T5PpfxHkAHHzbukgAAD8/n5qjPA0nXG6sdCB/aTLnmVY5ZV3t9WiLd2QYGWKazjFC0i0d9EGhGQiHICMBd9c=
X-Received: by 2002:a05:6602:2d09:b0:688:f387:aab5 with SMTP id
 c9-20020a0566022d0900b00688f387aab5mr9095353iow.107.1663674012642; Tue, 20
 Sep 2022 04:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220903152242.GA870876@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTxRWvUN3YuwdJ9WPmHH-v+Auozfc_OugpV_hpxC5K+4Q@mail.gmail.com>
 <20220914093423.GS246308@paulmck-ThinkPad-P17-Gen-1> <20220914102319.GA1936@lothringen>
 <CA+KHdyUb122cCaeLutzK8Ti-dk4D=iXCtQau=ZXkPRO-1cnD1A@mail.gmail.com>
 <20220914112251.GV246308@paulmck-ThinkPad-P17-Gen-1> <YygjfJkoUzxy9xd/@pc636>
 <20220919131152.GF4196@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQGPwkTQjxAb5p4OOhJkMA-L93JNTsa-WaXs0Ts7=Oakw@mail.gmail.com>
 <20220919223211.GJ4196@paulmck-ThinkPad-P17-Gen-1> <f061b798-e6f6-1523-52c3-12fe7966f809@joelfernandes.org>
 <a2882e80-1723-9004-f67a-cd8332aa701d@joelfernandes.org> <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
In-Reply-To: <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Sep 2022 07:40:01 -0400
Message-ID: <CAEXW_YRsp4HqwAPaDq9VYRptwgdcp7mPJjRH1msE42gzGajBjQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+rcu@vger for archives.



On Tue, Sep 20, 2022 at 7:37 AM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
>
>
> On 9/20/2022 6:29 AM, Joel Fernandes wrote:
> >
> >
> > On 9/19/2022 7:40 PM, Joel Fernandes wrote:
> >>
> >>
> >> On 9/19/2022 6:32 PM, Paul E. McKenney wrote:
> >>> On Mon, Sep 19, 2022 at 05:38:19PM -0400, Joel Fernandes wrote:
> >>>> On Mon, Sep 19, 2022 at 9:11 AM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> >>>>>
> >>>>> On Mon, Sep 19, 2022 at 10:08:28AM +0200, Uladzislau Rezki wrote:
> >>>>>> On Wed, Sep 14, 2022 at 04:22:51AM -0700, Paul E. McKenney wrote:
> >>>>>>> On Wed, Sep 14, 2022 at 11:38:32AM +0100, Uladzislau Rezki wrote:
> >>>>>>>> On Wed, Sep 14, 2022, 11:23 Frederic Weisbecker <frederic@kernel=
.org> wrote:
> >>>>>>>>
> >>>>>>>>> On Wed, Sep 14, 2022 at 02:34:23AM -0700, Paul E. McKenney wrot=
e:
> >>>>>>>>>> Agreed.  There could be a list of functions in call_rcu() that=
 are
> >>>>>>>>>> treated specially.
> >>>>>>>>>>
> >>>>>>>>>> But please be careful.  Maintainers of a given function might =
have
> >>>>>>>>>> something to say about that function being added to that list.=
  ;-)
> >>>>>>>>>>
> >>>>>>>>>> But one big advantage of this is that the list of functions co=
uld be
> >>>>>>>>>> private to ChromeOS and/or Android.  Maintainers might still b=
e annoyed
> >>>>>>>>>> about bugs sent to them whose root cause was addition of their=
 function
> >>>>>>>>>> to the call_rcu() list, though.  ;-)
> >>>>>>>>>
> >>>>>>>>> Are you sure you want this feature to be usable and debuggable =
by Android
> >>>>>>>>> only?
> >>>>>>>>>
> >>>>>>>> Adding on top of Frederic sentence. Sorry for that =F0=9F=98=80
> >>>>>>>>
> >>>>>>>> Do you mean to have the function names internally to be able to =
detect what
> >>>>>>>> is called and based on that func list place them in a lazy track=
?
> >>>>>>>
> >>>>>>> Yes, if needed.  But in addition to using call_rcu_lazy() where t=
he
> >>>>>>> callback functions' maintainers are good with it.
> >>>>>>>
> >>>>>>> Of course, if all relevant maintainers are OK with all the callba=
ck
> >>>>>>> functions being passed to call_rcu_lazy(), then their is no need =
for
> >>>>>>> the internal switching.
> >>>>>>>
> >>>>>> Then we would need map function names internally. I think what we =
got as
> >>>>>> a feedback from the conference session is it makes sense to improv=
e the
> >>>>>> batching in general of call_rcu(). Doing it we will improve and co=
ver
> >>>>>> all current users. So we do not need to distinguish lazy variant a=
nd a
> >>>>>> normal one from each other. Also we do not need to explain people =
the
> >>>>>> difference and switch to _lazy() across the kernel code. As we als=
o
> >>>>>> discussed one regular non-lazy call will revert everything back to=
 a
> >>>>>> problem that is in question.
> >>>>>>
> >>>>>> As Thomas said, look at it as: delay of invocation and if needed i=
n
> >>>>>> corner case do kind of expedited or sync support. For example call=
_rcu_sync().
> >>>>>>
> >>>>>> It is not up to me but... I just share my view :)
> >>>>>
> >>>>> Me, I am a bit pessimistic about the probability of us getting away=
 with
> >>>>> making the file-close RCU callback be lazy.
> >>>>>
> >>>>> After all, this thing is used across all filesystems along with a g=
reat
> >>>>> many things that are not filesystems.  It doesn't really matter whe=
ther
> >>>>> this laziness comes from a conversion to call_rcu_lazy() as in Joel=
's most
> >>>>> recent patch, lack of a conversion to call_rcu_expedited() as in Th=
omas
> >>>>> Gleixner's suggestion, or a mapping within call_rcu() as I suggeste=
d.
> >>>>>
> >>>>> Don't get me wrong, it would be great if this callback really can b=
e
> >>>>> always lazy, non-expedited, or whatever, but we should not take thi=
s
> >>>>> for granted.
> >>>>
> >>>> Are you saying we should not make call_rcu() default-lazy for
> >>>> everyone? According to Thomas, anyone expecting call_rcu() to finish
> >>>> in any reasonable amount of time is a bug, and that usecase needs to
> >>>> be fixed to use synchronize_rcu(). Are we saying now that that's not
> >>>> our direction?
> >>>
> >>> I am saying that Thomas can sometimes get quite enthusiastic about
> >>> a particular direction.  Plus I strongly suspect that Thomas has not
> >>> actually reviewed all of the RCU callbacks.
> >>>
> >>> Of course, I agree that it won't hurt to try out Thomas's suggestion,
> >>> which is why I did not object at the time.  But we should be fully
> >>> prepared for it to blow up in our faces.  ;-)
> >>
> >> Makes sense, thanks for clarifying. My impression was he does expect s=
ome pain
> >> in the short-term but the pain is worth not introduction a new opt-in =
API.
> >>
> >> I am wondering if putting it behind a CONFIG option will delay the pai=
n too
> >> much. Thoughts? I am assuming that we want the CONFIG to turn it off b=
y default.
> >
> > I tried a poor man's version of Thomas's idea by doing
> > jiffies_till_first_fqs=3D1000 and rcu.rcu_expedited=3D1 boot parameters=
. Of course
> > this just for trying has no regard for memory pressure and such so it i=
s in the
> > 'do not try at home' category.
> >
> > Then I tried jiffies_till_first_fqs=3D128 and compare before/after kern=
el logs.
> >
> > These are on ChromeOS hardware (5.19-rc4 kernel)
> > For jiffies_till_first_fqs=3D1000 Everything is fine until this point:
> >     8.383646] Freeing unused kernel image (initmem) memory: 1676K
> >    11.378880] Write protecting the kernel read-only data: 28672k
> >
> > I do not see this 3 second delay with jiffies_till_first_fqs=3D128.
> >     8.411866] Freeing unused kernel image (initmem) memory: 1676K
> >     8.656701] Write protecting the kernel read-only data: 28672k
>
> At least this could be because of the rodata write protection stuff calli=
ng
> rcu_barrier():
>
> From init/main.c
>
> #ifdef CONFIG_STRICT_KERNEL_RWX
> static void mark_readonly(void)
> {
>         if (rodata_enabled) {
>                 /*
>                  * load_module() results in W+X mappings, which are clean=
ed
>                  * up with call_rcu().  Let's make sure that queued work =
is
>                  * flushed so that we don't hit false positives looking f=
or
>                  * insecure pages which are W+X.
>                  */
>                 rcu_barrier();
>                 mark_rodata_ro();
>                 rodata_test();
>         } else
>                 pr_info("Kernel memory protection disabled.\n");
> }
>
>
> I think rcu_barrier() does not play well with jiffiest_till_first_fqs (pr=
obably
> because of the missing wake ups I found in the existing code, I should tr=
y that
> patch on this test..).
>
> Is it expected that a sleep involving jiffies_till_first_fqs does not get
> disturbed due to rcu_barrier() ? That seems like a bug to me. At least fo=
r
> !NOCB, I don't see any call the rcu_gp_kthread_wake() from rcu_barrier()!
>
> Thanks,
>
>  - Joel
>
> >
> > So I am guessing initmem uses call_rcu() in a 'synchronous' way or some=
thing, OR
> > it is doing synchronize_rcu() and rcu_expedited is not working at his p=
oint of
> > the boot. But this is just after initramfs filesystem is mounted so it =
should be
> > expediting.
> >
> > The next big delay I notice is from starting udev.d
> >
> > Multi-second delay with jiffies_till_first_fqs=3D1000
> > [    9.305123] SafeSetID: insecure policy detected: uid 213 is constrai=
ned [..]
> > [   15.499362] udevd[270]: starting version 225
> >
> > But not much delay with  jiffies_till_first_fqs=3D128
> > [    9.305123] SafeSetID: insecure policy detected: uid 213 is constrai=
ned [..]
> > [    9.490461] udevd[269]: starting version 225
> >
> >
> > So there's 2 issues at boot slowing things down right off the bat. :-\
> >
> > I wonder how much more 'fixing' is needed to make Thomas's idea less ex=
cruciating.
> >
> > Maybe a new call_rcu_lazy() API is the way to go after all?
> >
> > I'll try to trace the above 2 cases and see what the callbacks are doin=
g.
> >
> > thanks,
> >
> >  - Joel
> >
> >
> >
