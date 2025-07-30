Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126122F770
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914919; cv=none; b=jvy9pLIWmXIWpBGmbY7kHoI6UOrBbXNkILxg4HQ39WE6A7e5Uuy2qmZ3XRdURCK7t7X8b9Xa79kiczxr88qDXsx9MshtT7SIqQ6HSH/pVx7DeRCnxueBQWAFcAMnLbz/hk9JCQXQyPb3sVDHUQw1VBVBNsyOpga3T6EKN+VqjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914919; c=relaxed/simple;
	bh=jfql98Qqf0shdOGsC5v2Z64OSdT/3H+5m6YBOSS0t/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk+OkVYMrBJUn9u3k6J9mZWhC9QsVbGpOklCKvzL4AZzGGZioZcu0NdfyglVW1reOkW6Rz2l03xgugmaV3IvLP0kQxigKvwSLib/lpy5CUR7tjJOvPMd2cHTPzU8eEXn/3rMlRngiMz8kO93irDjTYcQewCbKt4KUDha6CzyCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PZX7+dty; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PZX7+dty"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dad3a179so41086666b.1
        for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753914915; x=1754519715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yms1ND+K2iHPyJhaAEq3bt/tYJep9pI9jrxC20mJJQw=;
        b=PZX7+dtyWeX/bGMXUYvKFsbXMrSIQLn7RWiF6k/8hL5wUR8948T0yYDYrwe+jX13kF
         wpiYqci0g4hEPM/BPokhOEqK6WArFrou1UlncLXlqEZa/94N0hs0uMmOT6O0c/iFE/Yd
         +3Y+p25C7YqJ2xdlgis0VZmFGx4TyMTdVvMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914915; x=1754519715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yms1ND+K2iHPyJhaAEq3bt/tYJep9pI9jrxC20mJJQw=;
        b=bh3jkXXCgGfsVFQ3zhi6gNhSkeDnYHOln2Qjwx/w4Arn6l1nnRn9OfV9DpWUNbsW2N
         P0F8GlI4fy8F1z5sJArukzNZ+8v1rBbp2u5dPFKc10S6rk9Fp18Rq1MeHwrRahT8NtWK
         E++1rpERfnWEweZ67i0q/IW6+eZIv8M37cLFILFSXIpcBRjwMGNk8Aut23acCN9yAbNG
         tQSSu9GRxjyBuY+971QrCOLFu2mdF3wyqF0C3FJT66hJZIbc3itE32mn8qimgz74BI7z
         pBV9YknCJFZb1wY3foWSCGFTmv8YAIfhItvKRxtiIWyt0MnhK7Sc/QwGUMBSPe0YJG1M
         WIPg==
X-Forwarded-Encrypted: i=1; AJvYcCWX9UFLxMJiFRlmLYQjSCeD/4uP4ioLUKNZM0cd/1fZ8LN776pnUh99eEAKGGjrnF7Q11E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPXo/e+lxqwdW6HwbeLBjDAHt2/YsCcnt5Z1jvkdfxrVidjwk
	za9iD0K4577aOtCjjRkBsVjH9195shj5SfcI7X7bCP+z5E84fYuvT5ynrW91l5nSZMsj9NsVLyx
	dlBJgu64=
X-Gm-Gg: ASbGncuHhUNR7NZ+5GO2DYpauQzkbB5LxL/sE6+h9J3WJJz+u/XnrBz8hiPmGZ3C7jS
	yAiPuvm3rsx43VaMYXaHTGlf2EaJtrDkkOO2KcVeSXXZhSF620XD0Vucb3iIbA95rRbHcrBIH7f
	6b2d0cQYmI2xDYeJCNvxlXb2OTINkh6ms6ldBCWUJ69AoGGb/I17Tu15Z6c4KhBVS7IS10LvzTJ
	sU88ssrz82FZQGjZAPTumMekMBBKxU7Ue+9f1iZmv7Np3Z7Ux7wrXXT6OjwUmiorDKB+WXnwQVt
	vV/4VWai97MhkRuDnE1eNMkcimR33m0puRqVZKVbfPUzTHrWVt6+A3z8n7j3WzfLhmHAdzqgTFe
	XAWok0GHQHvEC3NyeFRM2zxBptKx8V4V5jYop+dhr7hJmxlka+K3SB4cgdmFm8r5h9GdbmQ82Mt
	F3udCjQSU=
X-Google-Smtp-Source: AGHT+IGLfEUg4vlkt/dCWf4ZdCaY+SEY49Na2eVIBequvffuns8Nv2f8aE88u6V0eL2FMuhpdJ5YBQ==
X-Received: by 2002:a17:907:6ea9:b0:ae3:f3c1:a5dd with SMTP id a640c23a62f3a-af8fdaa8c9emr605014866b.61.1753914914862;
        Wed, 30 Jul 2025 15:35:14 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a243795sm8550266b.133.2025.07.30.15.35.12
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:35:12 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so401478a12.1
        for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 15:35:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1LmB0ZNSZ+/PGff1XEbjGKStSMDdPW2OMDeZFm0jPFZO/JVOZNAmkATD4IPSm1Kbs0Yw=@vger.kernel.org
X-Received: by 2002:a05:6402:2344:b0:612:7439:4190 with SMTP id
 4fb4d7f45d1cf-61586eeaec5mr5610895a12.10.1753914912312; Wed, 30 Jul 2025
 15:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726024605.GA17131@neeraj.linux> <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
 <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
In-Reply-To: <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 15:34:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>
X-Gm-Features: Ac12FXyWdse7MSeyh8So1MlV_rrBfw4q_ZgkpKwosCbZujeD34m-S0Vu_GNMhWQ
Message-ID: <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.17
To: paulmck@kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, joelagnelf@nvidia.com, frederic@kernel.org, 
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, 
	Tze-nan.Wu@mediatek.com, a.sadovnikov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 12:24, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> As it happens, I will be sending the pull request for the v6.18 merge
> window, so I will stop doing my usual octopus merges (hey, they *were*
> cool!) and instead merge each branch separately, with each merge's commit
> log giving a synopsis of the commits in the branch being merged.

Note that octopus merges aren't a no-no per se. Sometimes they make
perfect sense, particularly if there's a handful of really trivial
branches with just a commit or two each.

Then an octopus merge can be a really convenient way to avoid having
as many merges as you have "real" commits.

So don't take my comment as a "never use octopus merges".

Take it more as "octopus merges have some downsides, and making _any_
merge without an explanation for it in the commit message is bad".

The main downside of octopus merges really is just bisectability:
because even if the problem doesn't end up being the merge itself, an
octopus merge can make it fundamentally hard to do the "cut the
history in two roughly equal points for testing".

But again, that's not a problem if you have just a fairly small
handful of purely trivial commits.

So people just need to balance the "octopus merges are cool, and can
avoid pointless repeated silly small merges" with "octopus merges can
make for bisectability issues and should be avoided for anything even
halfway comples".

(Also, try *very* hard to avoid octopus merges when any conflicts
exist - even trivial ones. Octopus merges with conflict resolution
take "that's hard to follow" to a whole other level, to the point
where you really shouldn't even try).

> If you have a best-practice series of merges example in mind, could you
> please point me at it?

It's hard to give a good "typical" example, because I don't think
"typical" exists.

Sometimes a simple one-line merge message just stating "Misc fixes for
subsystem Xyz" really might be the "proper" merge message.

Because maybe that branch really had all just tiny uninteresting
fixes, and git shortlog entirely describes it all to the point that
writing anything more would just be wasting everybody's time.

Honestly, the merge messages you guys send me for *my* RCU merge are
fine - the only thing I ask for is that instead of describing the
branches with an esoteric branch name, you write them out for humans.

So having the header read "Improvements expedited RCU grace periods"
or something is just _soo_ much more understandable than
"rcu-exp.23.07.2025", wouldn't you agree?

As to the merge messages for *your* own merges, where you just put
several branches together in order to send the result to me: knowing
that there will be a more complete message in the upstream merge, I
think the main issue is to think about people who hit that merge
because they have some issue.

So again, it might be because somebody ends up hitting that merge
during bisection, or has some other reason why they are looking at
that merge in particular, rather than the "bigger picture" upstream
merge.

In other words, please write merge messages with the intended audience
in mind. They don't necessarily need to be the same kind of
full-fledged explanation that I want to explain why I'm merging (and
for people who follow the development process: people most definitely
look at the pull requests that come upstream, and it's informative to
not just me, but you find tech press etc looking at them too).

But you should at a minimum think about "what if somebody hits this
during a bisection". Give those random developers a clue about what is
going on. Don't just make it be that "Merge branch XYZ", because that
tells _outsiders_ so little.

Does that make sense as an answer?

Anyway, I'm happy to say that if you are looking for _examples_ of
merges, we have tons of them. I'm proud of the fact that I think
kernel commit messages in general are very good, and when I compare
them to other projects I feel like we tend to do a stellar job. And
I'm not just patting myself on the back, we have tons of good
examples.

So you can do a

    git log --merges

in general, and while you'll find some that just list branches, I
think most of them tend to be very good these days. Look at the
networking and bpf merges, for example (so typically Jakub and
Alexei). Or the SoC merges (Arnd), or the VFS merges (Christian
Brauner).

Or really most of them. I started looking for more names (the ones I
mentioned were people I already knew wrote good merge messages), and
really my reaction was that "most of them are great".

Good on us.

        Linus
