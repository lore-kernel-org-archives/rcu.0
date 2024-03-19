Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD28174B
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864705; cv=none; b=AsuPaMWtfKJmSVXOwWgULCXl1epGigWecpLbihwu8YmPaSKmyJYcsNqv4FbiUBQQx3HZupMoEKAgrkQEiVS8riJFmaAdBYkZiuugxKrRXKjFjAiK/cZ4pm7PSL/xzMsOvgfzEo0p/lnhzhuOa046GwA8dDdUE8EX/H97LuJ+uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864705; c=relaxed/simple;
	bh=xDReH+sKvb3yZpghXg7MFLHuHYKu1LV+To9aAVu95Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwxMR2VzLkurfu2BekzmHmlKBoNGumipadue0sdDP1VESSW4pDQFjJHxy3tXVHXT02rASABq6XTrKfZXSz8tAGSTnVAEgVzjzNY89esyzHH6G3Is4F5X8/MnYeVweHIQG9fZo6VobOZzALDtCA8ihFW5afNkRgx+G8D2Hj5sip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=p6jcdcMG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p6jcdcMG"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d485886545so94722671fa.2
        for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710864702; x=1711469502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea9pUCpkU7VzFGx+RNOUqCDuxIXFA6Y8mBURHN8vYR8=;
        b=p6jcdcMG75QkXPAIS4fCsDqdWVnpkGNHlQTnCArwTJ/uas2Hm4BZLhaJmz978MFPPI
         QEX0/bzy8ftum3zhiQtw6DE/CA7B3RXasxjg5wr5hB6yi0ofcGTG0cdOtHhohC2jA4dD
         GglV29q/MSutka3IZbn/SVrNqJcOV5OIcETPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864702; x=1711469502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea9pUCpkU7VzFGx+RNOUqCDuxIXFA6Y8mBURHN8vYR8=;
        b=TLndX5i73lPPa495tHYZsYWbEbmdHgeVzBTohVOxKCJ5TtzaHEu51swfp4KaXLQV6D
         ly0Mmij+wD5CVhFA5MOn0gLT4scXxNHKF59MqcQ7bcc3dQeT0w+ZIFYsh1ysXYBpcVF3
         j9qIODCqhjcTpLDbB/Snt0bRgI5lqVv9LEfqKSY5jhJSTBJanP9y9wGeWvPiYoqIPbMW
         CHjTrjYZsQj4P87C1OMq2hzKRlYIH/Bk6B+LqfvFxLb/VvqwyNKwPW6DCos+9rMH+28Q
         Y8EYe3K6JVTn3nF35PNnccIvOkzzIu0JFtS1v91I4wT9xULgJ1K+pgMHY+oUqGt4/xkq
         dN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTvRDGebOc5elW2Zo6YpFVe0xqagb0rYgPyld6QJGnmAtHwQcar18oy9aCmyotss4jLdFiu8H4VgVopQ3CFjKMnPjk
X-Gm-Message-State: AOJu0YyXRFfj1OXIoOjBeE1stfeg301yd6RK1mt7jskaYrAwmmg42Kv0
	wmMozJWbxNlmbBC4V+JyfIsdy89/2bQnyaLi065+g0J4yAoa5ej97Nb88ZJq/7NBJRfFihHqyTI
	gl3a4ewck2khxntA3gCAjW2IGCWUn8HhtL84S9A==
X-Google-Smtp-Source: AGHT+IEe3I/uIkO/arbr7b5WiC6iZO4umeHiIPFSH3m97OQTSB7zr/nqzM6nfMU40MNsH7gi9AkA6iyeDJBA8c/Mps4=
X-Received: by 2002:a2e:3c07:0:b0:2d4:714b:4c5d with SMTP id
 j7-20020a2e3c07000000b002d4714b4c5dmr7600021lja.44.1710864701424; Tue, 19 Mar
 2024 09:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZflgfrjZSZdqrLLw@pc636> <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636> <20240319160252.GA186534@joelbox2>
In-Reply-To: <20240319160252.GA186534@joelbox2>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 19 Mar 2024 12:11:28 -0400
Message-ID: <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, 
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:02=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Tue, Mar 19, 2024 at 03:48:46PM +0100, Uladzislau Rezki wrote:
> > On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
> > >
> > >
> > > > On Mar 19, 2024, at 5:53=E2=80=AFAM, Uladzislau Rezki <urezki@gmail=
.com> wrote:
> > > >
> > > > =EF=BB=BFOn Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes w=
rote:
> > > >>
> > > >>
> > > >>>> On Mar 18, 2024, at 2:58=E2=80=AFPM, Uladzislau Rezki <urezki@gm=
ail.com> wrote:
> > > >>>
> > > >>> =EF=BB=BFHello, Joel!
> > > >>>
> > > >>> Sorry for late checking, see below few comments:
> > > >>>
> > > >>>> In the synchronize_rcu() common case, we will have less than
> > > >>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the =
kworker
> > > >>>> is pointless just to free the last injected wait head since at t=
hat point,
> > > >>>> all the users have already been awakened.
> > > >>>>
> > > >>>> Introduce a new counter to track this and prevent the wakeup in =
the
> > > >>>> common case.
> > > >>>>
> > > >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>> ---
> > > >>>> Rebased on paul/dev of today.
> > > >>>>
> > > >>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> > > >>>> kernel/rcu/tree.h |  1 +
> > > >>>> 2 files changed, 32 insertions(+), 5 deletions(-)
> > > >>>>
> > > >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > >>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
> > > >>>> --- a/kernel/rcu/tree.c
> > > >>>> +++ b/kernel/rcu/tree.c
> > > >>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
> > > >>>>   .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> > > >>>>   .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cleanup=
_work,
> > > >>>>       rcu_sr_normal_gp_cleanup_work),
> > > >>>> +    .srs_cleanups_pending =3D ATOMIC_INIT(0),
> > > >>>> };
> > > >>>>
> > > >>>> /* Dump rcu_node combining tree at boot to verify correct setup.=
 */
> > > >>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work=
(struct work_struct *work)
> > > >>>>    * the done tail list manipulations are protected here.
> > > >>>>    */
> > > >>>>   done =3D smp_load_acquire(&rcu_state.srs_done_tail);
> > > >>>> -    if (!done)
> > > >>>> +    if (!done) {
> > > >>>> +        /* See comments below. */
> > > >>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pendi=
ng);
> > > >>>>       return;
> > > >>>> +    }
> > > >>>>
> > > >>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > >>>>   head =3D done->next;
> > > >>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(=
struct work_struct *work)
> > > >>>>
> > > >>>>       rcu_sr_put_wait_head(rcu);
> > > >>>>   }
> > > >>>> +
> > > >>>> +    /* Order list manipulations with atomic access. */
> > > >>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > > >>>> }
> > > >>>>
> > > >>>> /*
> > > >>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(=
struct work_struct *work)
> > > >>>> */
> > > >>>> static void rcu_sr_normal_gp_cleanup(void)
> > > >>>> {
> > > >>>> -    struct llist_node *wait_tail, *next, *rcu;
> > > >>>> +    struct llist_node *wait_tail, *next =3D NULL, *rcu =3D NULL=
;
> > > >>>>   int done =3D 0;
> > > >>>>
> > > >>>>   wait_tail =3D rcu_state.srs_wait_tail;
> > > >>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(voi=
d)
> > > >>>>           break;
> > > >>>>   }
> > > >>>>
> > > >>>> -    // concurrent sr_normal_gp_cleanup work might observe this =
update.
> > > >>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > >>>> +    /*
> > > >>>> +     * Fast path, no more users to process. Remove the last wai=
t head
> > > >>>> +     * if no inflight-workers. If there are in-flight workers, =
let them
> > > >>>> +     * remove the last wait head.
> > > >>>> +     */
> > > >>>> +    WARN_ON_ONCE(!rcu);
> > > >>>>
> > > >>> This assumption is not correct. An "rcu" can be NULL in fact.
> > > >>
> > > >> Hmm I could never trigger that. Are you saying that is true after =
Neeraj recent patch or something else?
> > > >> Note, after Neeraj patch to handle the lack of heads availability,=
 it could be true so I requested
> > > >> him to rebase his patch on top of this one.
> > > >>
> > > >> However I will revisit my patch and look for if it could occur but=
 please let me know if you knew of a sequence of events to make it NULL.
> > > >>>
> > > > I think we should agree on your patch first otherwise it becomes a =
bit
> > > > messy or go with a Neeraj as first step and then work on youth. So,=
 i
> > > > reviewed this patch based on latest Paul's dev branch. I see that N=
eeraj
> > > > needs further work.
> > >
> > > You are right. So the only change is to drop the warning and those br=
aces. Agreed?
> > >
> > Let me check a bit. Looks like correct but just in case.
> >
>
> Thanks. I was also considering improving it for the rcu =3D=3D NULL case,=
 as
> below. I will test it more before re-sending.
>
> On top of my patch:
>
> ---8<-----------------------
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0df659a878ee..a5ef844835d4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
>                         break;
>         }
>
> +
> +       /* Last head stays. No more processing to do. */
> +       if (!rcu)
> +               return;
> +

Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
in any case, the original patch except the warning should hold.
Still, I am testing the above diff now.

 - Joel
