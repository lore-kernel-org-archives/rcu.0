Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77435203C
	for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900323; cv=pass; b=bfQZPA/x/t1JrdOaJNmvCMGNn4NjOlNy3+qOOGU1OJfu3Vo3XBuNb1PeLZtQPdQIuC0nWh4rzm6FzTII0qT57VrY8EnO624dtq0/vpLSj9NmeAqhjhNnhf6s+P+tQvoHhPqOliH9TRYQAmcjnkv/ohW+sZhYlawyePpzk3Cepgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900323; c=relaxed/simple;
	bh=efwpqbn4KqWJ83/+b8Z3Sx2CVCm9Kiqp5MA7PhTFAxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVWrFuLIyCVWWHjI6X2oBB5HiOnwUGLvT6YPdOVDDZATaE6TCa+CVyGcmXVOmnC/3DWtVO4uKDVkxKrXv91nh8wxPkbE/FUx8lloALl8AY3IABTpUbXNX1tj3jqJVU29js9NoD2RgC+210Qd/vLtyD+4g4xnV7gBQtPv9emmFrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OILuzQQN; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OILuzQQN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93cb9e9405fso150225585a.2
        for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 07:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900320; cv=none;
        d=google.com; s=arc-20260327;
        b=ignzehM0vTknMhSKj9lgZQroLLwW9ARTkgiC6hqxuAKX7zZbMcsz/bhZKb+5+xkpQn
         lKCLGmzegFgDY/mK+pjesAyB7V2fwY4TLpw+OpqVR9RCdlplIKjjGdtEQTHCjAf2mT9o
         mjJyeOvpX+5eFYbplVRZeFusXoihfprGRGZcxf5Kj1ocRMqHVbHFfB/3Z/Q0YXKSsenv
         LQuFoGvxPEyL+BsF1u2FEg9K/Ceiu9+tnM/SjJ9+0vXyb39jnrjxjsIKcQQkqs6IPsoT
         XuS1XEEjG7+oazagbaWfdESbtnj3MaUEI0bxY12M/b6skHzx+ud+8bDcdpV8qO4VoDnG
         7WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        fh=XbM2x/bzDbA9Vdo2bVwkYkcUGThGDp0A89kbimTzB1s=;
        b=A3iTK8qsHEuuSz9nqQG0+UzQiPEGHMKmuGsSMG/c/1ZCPJcFECYLsDOtjul+0fdcHX
         5xw/ZxAq+aK7UCt7nsZZj7xvScPY+Hujkp0ZOBPHM06Tmes+ljS1+UmRL7RY8xy8XN12
         Regk3Y8Zv0i0+Wq7iV1WThVDN9a5wA5blSkyu8Konp2oDM1OvQsoEm1p5nKsNkf87gvt
         1NDCOR2UHpoUZ07MAIYk69NxMfR+VbrtReNTp8phrmSHhLHxl4OeXlYDLU/BbFszJzMS
         5kH+JmCcixBtdC/nPWrYx4+f+uFUmFFJdNKiJ0kGG1rOafhX+tmvQyrcKEGaD+/j9Ax4
         rw1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900320; x=1792505120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        b=OILuzQQNGHitUqKN6lSOHQRrLS5lHihOw7H22eT0VBoJwPqFgkweGJNKLeMOqKAjf4
         zvfkgJfM+GXapEQwdQkKBKXeJCp5lVdeKdkQnQ8CeODyN6OfoFsrNvgqGBwLJndNn3yv
         lsdEd0lkmZcaMkxR7sHIQeCzd7PdTPDXo5C8Z2oelqXgQbv7VmWVf94YaXpUjQD9N/I9
         VlniGbbz3zrOHWwP2aVA8tc5tsr72LpZ7gfdg2fJlXEhly2gmVTsSLGJGZfwpb5dI321
         pwTxc8xC7xTcvLqstvZghpwoK/b2LINceM4Sla6EoH8sec8hDHYlfhL1h1W8J28OVIG9
         71iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900320; x=1792505120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        b=EMx158WR9+FZpeojErw7B+2/gbxd4R62wGhJZgrsVEVldEqgqRqDTlnv5nE4elA2E2
         hjnUJtKbN8gQalat+dHymbvoO+Y0a9xGwPQDc/V7ws2TAInAJNkJCGW7kzDhCKQdEuSs
         /5+4jaZ+KlzkTKtxh6h7tTddOrdnEKu4oaa5rLMVxAQjamFfh0K1b61gO7cAYsV4KJg+
         egpQ3CQlv8ylmeFN6gsSAmcFsHY7ms/nDAtGygtFKOmZQUwBhVdbViTLxEi6QdsY80EC
         KByFGj0gIor+5z/1xMBIk04ei8qe4iuGyGW+ogTZKxMEXmhcmuhhJkMAJpiRfwwaZg51
         CJNg==
X-Forwarded-Encrypted: i=1; AKwUvBzJeKHhp+QXECbcXZx6qek4rZUOpnFShEUSbwi4tbkqRQnm9jCcph6YGiH/UZNtaFT8B3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV2SZCdl49900wT8aByIqHNAF+Q7Eh7B9lUPle+zqbDJgvP41w
	RuqDPlBJYD/RnfNrWoRp9VShnLtJQynBfdxcuAcpmEqDDM7nwpHcqXQcU90L3t2egocjg2YlyP4
	7oRod+wn+WzKnot4j18ZX87H9UfqTZNc=
X-Gm-Gg: AYBFou2xiwxx5k2xzPGR9Ku0i7IUMg8hHoupK816G3qXq7wd7+V+owzor4xKu2kjwbL
	hRFsGlK3oBTELueWgPV5j80EVLzHkrrNYiX8pQ3atPlR2GPIlRZ3eQf8C2tBBsXzt4Zy3so4GDl
	9iDtPztfgDYtkCSkadjWI/2AnBHBgu1/OmZ+e/LqC83We8KIcHYbxUYtj3+NylRiTiXLPrnk9Pu
	eZ/cOkEVZ1UfX7iPL2IwsiJQweaACE77bXtcHu7OkSVwVr5dkU8Xcr0QZLpMzXa7+erc9GObPZM
	u6hf7w9lkdfz1f26z6f7XF3Io/+RdOdJkqpqBJozIim1loAtucFKsKvPewX7t63qdQOTGD+PW8u
	+9XCn5yljSVu4AuHz00JublI=
X-Received: by 2002:a05:620a:3947:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93ebd24b2fcmr2220976385a.37.1791900320079; Tue, 13 Oct 2026
 07:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com> <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
 <as4ooZSWA2lAIceu@tardis.local> <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
In-Reply-To: <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 13 Oct 2026 22:05:08 +0800
X-Gm-Features: AclHuK9Y6wjNtKPnooCMgRZOapMzF0kyKCufRscUU_wsuFWoqVB6jP59bjMM3m0
Message-ID: <CAJhGHyBd5wuLO9H7bHJDO==2=z8MGQ3ehvszLiB1brztpRXu8A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, lianux.mm@gmail.com, stern@rowland.harvard.edu, 
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:04=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-10-13 08:48, Boqun Feng wrote:
> > On Tue, Oct 13, 2026 at 03:40:36PM +0800, Lai Jiangshan wrote:
> [...]
> >>
> >> This breaks the forward-progress argument used by the underlying
> >> hazptr implementation: after removing an object from publication,
> >> there should not be a continuing stream of new readers acquiring
> >> that same object. Here, the bucket is never unpublished.
> >>
> >> For example, let B be the bucket containing key K:
> >>
> >>    Updater                    Reader                 Scan kthread
> >>    -------                    ------                 ------------
> >>    Unlink K from B
> >>    hazptr_synchronize(B)
> >>                               Acquire B
> >>                                                      Observe B;
> >>                                                      retain waiter
> >>                               Release B
> >>                               Acquire B again
> >>                                                      Observe B;
> >>                                                      retain waiter
> >>                               Release B
> >>                               ...                    ...
> >>
> >
> > This is more of an implementation issue,
> I agree with Boqun about the point that this is really an implementation
> issue.
>
> If we care about forward progress in the scenario of a repeated
> address reuse, we just need to wire up a "0/1" low bit phase tag and
> make hazptr acquire pick it up and set it within its hazptr slot. This
> will ensure forward progress in that scenario. hazptr synchronzie
> would therefore flip this phase between 0 and 1, and check that the
> pointer it's looking for is not set in the other phase, in alternance,
> handling both phases within one synchronize. Indeed, this phase concept
> comes from the realm of RCU implementations.

Regardless of which implementation approach is adopted, this would effectiv=
ely
introduce a new read-side synchronization mechanism based on hazard pointer=
s.
I would prefer to see it introduced under a distinct name in the
kernel, so that its
semantics and intended usage can be clearly distinguished from those of
conventional hazard pointers.

Thanks,
Lai

>
> I think that the overall mindset so far has been "RCU does this" and
> "Hazard pointers do this" as if those were entirely predefined
> mechanisms. I think the way forward is not "one or the other", but
> rather to combine the strengths of each of those mechanisms into
> something better.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
