Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EFCEE7FF2
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 13:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIHNcx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIHNcx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 09:32:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD3119BC
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 06:32:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso36525501fa.1
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694179967; x=1694784767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9oHTFY/Hdsxk6HvjwRU+raxe2zWZEOWI9WhHxivUro=;
        b=omwbINPf1DMnTBXkQksXyaGFXz8s7+Ql6PIZv0kgxp1V43j8QYaqythw+NQI6BjWTX
         vGSvRBIfqt/L/aopvMVt6dp+PQLfdjySsXkeSIsb+XeL6C6xrA533aVkuZpUkHKEM5fy
         ZcpXmrkyQgVR9ujA7vLmuLhpHojeBffGenvcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179967; x=1694784767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9oHTFY/Hdsxk6HvjwRU+raxe2zWZEOWI9WhHxivUro=;
        b=TRWizBpARmNW5W0FW0LPjP/clIsgpRZagUWHxMn1b0mbqEv5w3QLfeq37dKOP6a+qn
         5I4v151qktoWBstulr+WI0Y+YC4R6DQfINvLbct3SlaT+jsKaxGph0NtjlM1DX1BJb7z
         Lbbbl3hI8NmqFC/1KRyfOHFkRHhOp+Zv87ohwBPQb6aN2180K/I5Gpld45oiNK24VALS
         +RyOYuAd9PwRB1wvYOP4/4VhIvTeH/E/EP++iKML27KwjWybEBhe6rwv0uqqBPhRem8m
         lz+5H0jPBTW6oneM0JjZaFF+orASpgaVsYuHjKJdV5bToQnxFh22L5ZpOxG1dur9BA/D
         10DA==
X-Gm-Message-State: AOJu0Yw1Qwt6wqxe+w3veYt+qmAhxtzLmRex9Um6cZNKNUGTWHhWQJOQ
        mTJhvPLUxNBtakvATNQgkCQi448kJ36/E0Y6MktmZpYtHKVGrRVx828=
X-Google-Smtp-Source: AGHT+IF377mCTegOIsDYETYcvtTkYGRB4Swoczzgrw1u0gLCK29vtraDCwKv6XeGEjN3IxspywKB3uvZeM/yWUsVF6o=
X-Received: by 2002:a2e:9b4c:0:b0:2bc:d6d8:8ab5 with SMTP id
 o12-20020a2e9b4c000000b002bcd6d88ab5mr2009442ljj.24.1694179966465; Fri, 08
 Sep 2023 06:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
 <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org> <CAEXW_YStFf6Lt43GiLMCO5wBwCJU3aWcv5GvX0_8xaeZTFKMkA@mail.gmail.com>
 <0526cf20-7d6f-4e2b-a28e-692ff8bc5955@paulmck-laptop> <ZPsIZhhZ1sy/45X+@lothringen>
In-Reply-To: <ZPsIZhhZ1sy/45X+@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 09:32:35 -0400
Message-ID: <CAEXW_YTpfjGsO1_87T7TRBY4+Ze63VYHOshJ3JbF3TO9tiEkOw@mail.gmail.com>
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 8, 2023 at 7:41=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> On Fri, Sep 08, 2023 at 01:27:06AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 07, 2023 at 08:51:43PM -0400, Joel Fernandes wrote:
> > > On Thu, Sep 7, 2023 at 4:03=E2=80=AFPM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> > > >
> > > >
> > > >
> > > > > On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org=
> wrote:
> > > > >
> > > > > =EF=BB=BFOn Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes=
 wrote:
> > > > >> Hi,
> > > > >> Just started seeing this on 6.5 stable. It is new and first occu=
rrence:
> > > > >>
> > > > >> TREE04 no success message, 234 successful version messages
> > > > >> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > > > >> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1=
253
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [   38.388342] Call Trace:
> > > > >> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3=
637
> > > > >> f0x2 ->state 0x2 cpu 6
> > > > >> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5=
501
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1=
0505
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1=
3781
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1=
6544
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1=
8941
> > > > >> f0x0 ->state 0x2 cpu 6
> > > > >> [..]
> > > > >>
> > > > >> All logs:
> > > > >> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linu=
x-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10=
.25/TREE04/
> > > > >
> > > > > Huh.  Does this happen for you in v6.5 mainline?
> > > > >
> > > > > Both the code under test (full-state polled grace periods) and th=
e
> > > > > rcutorture test code are fairly new, so there is some reason for =
general
> > > > > suspicion.  ;-)
> > > >
> > > > Ah. I never saw it on either 6.5 mainline or stable till today. Eve=
n on stable
> > > > I only ever saw it this once. On mainline I have not seen it yet bu=
t I do test
> > > > stable much more since I have been on stable maintenance duty ;-).
> > >
> > > I did a couple of long runs and I am not able to reproduce it anymore=
. :-/
> >
> > I know that feeling!
>
> Same here, this is after all the reason why we keep the tick dependency w=
ithin
> the hotplug process without really knowing why :o)

Heh. I have been running into another intermittent one as well which
is the boost failure and that happens once in 10-15 runs or so.

I was thinking of running the following configuration on an automated
regular basis to at least provide a better clue on the lucky run that
catches an issue. But then the issue is it would change timing enough
to maybe hide bugs. I could also make it submit logs automatically to
the list on such occurrences, but one step at a time and all that.  I
do need to add (hopefully less noisy) tick/timer related trace events.

# Define the bootargs array
bootargs=3D(
    "ftrace_dump_on_oops"
    "panic_on_warn=3D1"
    "sysctl.kernel.panic_on_rcu_stall=3D1"
    "sysctl.kernel.max_rcu_stall_to_panic=3D1"
    "trace_buf_size=3D10K"
    "traceoff_on_warning=3D1"
    "panic_print=3D0x1f"      # To dump held locks, mem and other info.
)
# Define the trace events array passed to bootargs.
trace_events=3D(
    "sched:sched_switch"
    "sched:sched_waking"
    "rcu:rcu_callback"
    "rcu:rcu_fqs"
    "rcu:rcu_quiescent_state_report"
    "rcu:rcu_grace_period"
)

Thanks.
