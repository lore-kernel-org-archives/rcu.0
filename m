Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3825C61DA4
	for <rcu@archiver.kernel.org>; Mon,  6 Mar 2023 19:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCFTyv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCFTym (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Mar 2023 14:54:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46035392A9
        for <rcu@vger.kernel.org>; Mon,  6 Mar 2023 11:54:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d36so11151922lfv.8
        for <rcu@vger.kernel.org>; Mon, 06 Mar 2023 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678132479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KBFMxUHRx/IWO17z+IE5jZIuC93oYNZnk028BTaUVM=;
        b=oJgk5fgzCmKHbfvUqP/CXv/z4fjBeGtH2ZQf9O3F2g2Q0j2kYsCGRHAtLajQVIVH8z
         0TKDLXBn3LhL52QFeHztbKxWVIv9VdbZ5m4VNSfJ6gXHdPg+Ef4uihQjXO2aQ6wIzTLL
         qJbl3SRP4CzuNlEKn9RFQLRurodH1oXg5tBJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KBFMxUHRx/IWO17z+IE5jZIuC93oYNZnk028BTaUVM=;
        b=4nwey6IZDxgZ/H6w+1Jh1wTQrWTBNR/bhtYl3OnXGXbj8pBTk8EQg24rGgk6Nvn5c1
         BQpdAQJp4tEnxf4kxVcpqTy6s2YHeRwu24497vSU+N5XcaynGo2TUztSzBL6bvkQcCqo
         zK/DrJWHb4cmh71Q5KYfJXTv5f8PWQJU/iVbu6CUO4+iV+g0FlSPyy16ZNEXGgYaHsCt
         dneECZymMc28XA9ATiZFwZnhLNrI0hLey3V79QkW7FNHbroVXOv6mBCQAp7i9Y8qo89g
         zufsZRNf9/KqIvueHDBVviDochSnSr5qWZ/1jWYl9OHcF878xmwUzGebUzzjOCWfbbrY
         vhOw==
X-Gm-Message-State: AO0yUKUSrCKnonGscctSYcMWNA0xdz/yxvbWD8QfiXpPuTjBwwnjDzzp
        lG3dWT1JOg1PzfkJnGjiF72qG3vzd/15Tne9C+Y44w==
X-Google-Smtp-Source: AK7set8M5Rula9Z0Knr245Ln9rMlyUmpiicajR5ZsXPy0vAslTvLqNGnsCGKqkJfyueMv4H2CYzu18C5WRjakBWCRZI=
X-Received: by 2002:ac2:4a86:0:b0:4d5:ca42:aeeb with SMTP id
 l6-20020ac24a86000000b004d5ca42aeebmr3553377lfp.11.1678132479490; Mon, 06 Mar
 2023 11:54:39 -0800 (PST)
MIME-Version: 1.0
References: <ZAR//FKO4syzapk6@pc636> <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1> <20230306144948.GA3280216@google.com>
 <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1> <20230306151203.GC3280216@google.com>
 <ZAYYBEnIZEfUhBYW@pc636> <20230306165501.GX1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAYebhiXJAct1vUS@pc636>
In-Reply-To: <ZAYebhiXJAct1vUS@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Mar 2023 14:54:28 -0500
Message-ID: <CAEXW_YSY=q2_uaE2qo4XSGjzs4+C102YMVJ7kWwuT5LGmJGGew@mail.gmail.com>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 6, 2023 at 12:10=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Mar 06, 2023 at 08:55:01AM -0800, Paul E. McKenney wrote:
> > On Mon, Mar 06, 2023 at 05:42:44PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Mar 06, 2023 at 03:12:03PM +0000, Joel Fernandes wrote:
> > > > On Mon, Mar 06, 2023 at 07:01:08AM -0800, Paul E. McKenney wrote:
> > > > [..]
> > > > > > > 7.  We then evaluate whether further cleanups are needed.
> > > > > > >
> > > > > > > > > My feeling is
> > > > > > > > > that, we introduced "_mightsleep" macros first and after =
that try to
> > > > > > > > > convert users.
> > > > > > >
> > > > > > > > One stopgap could be to add a checkpatch error if anyone tr=
ies to use old API,
> > > > > > > > and then in the meanwhile convert all users.
> > > > > > > > Though, that requires people listening to checkpatch compla=
ints.
> > > > > > >
> > > > > > > Every person who listens is that much less hassle.  It doesn'=
t have to
> > > > > > > be perfect.  ;-)
> > > > > >
> > > > > > The below checkpatch change can catch at least simple single-ar=
g uses (i.e.
> > > > > > not having compound expressions inside of k[v]free_rcu() args).=
 I will submit
> > > > > > a proper patch to it which we can include in this set.
> > > > > >
> > > > > > Thoughts?
> > > > > > ---
> > > > > >  scripts/checkpatch.pl | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > > index 78cc595b98ce..fc73786064b3 100755
> > > > > > --- a/scripts/checkpatch.pl
> > > > > > +++ b/scripts/checkpatch.pl
> > > > > > @@ -6362,6 +6362,15 @@ sub process {
> > > > > >                       }
> > > > > >               }
> > > > > >
> > > > > > +# check for soon-to-be-deprecated single-argument k[v]free_rcu=
() API
> > > > > > +             if ($line =3D~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> > > > > > +                     if ($line =3D~ /\bk[v]?free_rcu\s*\([^,]+=
\)/) {
> > > > > > +                             ERROR("DEPRECATED_API",
> > > > > > +                                   "Single-argument k[v]free_r=
cu() API is deprecated, please pass an rcu_head object." . $herecurr);
> > > > >
> > > > > Nice!
> > > > >
> > > > > But could you please also tell them what to use instead?  Sure, t=
hey
> > > > > could look it up, but if it tells them directly, they are less li=
kely
> > > > > to ignore it.
> > > >
> > > > Sounds good, I will modify the warning to include the API to call a=
nd send
> > > > out a patch soon.
> > > >
> > > Maybe compile warnings? Or is it too aggressive?
> >
> > That is an excellent option if people ignore the checkpatch.pl warnings=
,
> > thus forcing us to delay past v6.5.  So Murphy would argue that we will
> > in fact take your good advice at some point.  ;-)
> >
> OK. On this step it sounds like a bit aggressive. checkpatch.pl should
> be fine as a light reminder :)

Agreed :). Also on some configs AFAIK, I believe the build will break
with _any_ build warning so checkpatch is a good first step instead.

I will post the checkpatch change today (also to get any early feedback).
thanks,

 - Joel
