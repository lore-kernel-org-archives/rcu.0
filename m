Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE118DF75;
	Thu, 19 Sep 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727967; cv=none; b=HnwecbTqQosSWHXDfsSPHMF4x/SjE5T0jtJJs7xCxAC2KEVqu6YVTYHJe4stcwXAxQv8JkxGXj8ckzPopMe7JTn4npXrKzNvV3wo5DfPT8VoaM4M2MAopo0ZGcViKc33yFt5utoym/qUrZFP6HFAST4BYvZfgbjohHXVmiauNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727967; c=relaxed/simple;
	bh=9aHqUhixK4+JY8VFuANSZKR87LDy5lGcOwNIlr+8K6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKDZBBtOf4aIKvmUsCWFYnbrm0v+QPVb2w36nJznVWJ8N3dkCKtxMYYGgm6QNOuj6Vlgvlx75GllZR4aGNJ9KsX8V2CgbWvLl1/ZSvhGRz83liF2kHBvPSSQ2oeMoZdNz7BiJ2PM008AYYhK3FjeSzh5hesyZLDQsEGQP8e/N8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfnE4z+0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfnE4z+0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so456730a91.3;
        Wed, 18 Sep 2024 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726727965; x=1727332765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciBDeJbMoYShPX4NBgaU7Dv6KXNedCl1tbMLTbPne+k=;
        b=dfnE4z+0AVi/OlNmVSZ3wWiL3eh4PUYh8+JH1iq/G/5eOXimh5qR0rkgHSlygQ6/gF
         rzcT7tmGdfZB6Dt6VARI427/KsDvOhGTYw2NfPAAiy9UsTjQSczfkCcc+UYhojTb7o8U
         wKslv9cy+OzFyS7JRjXNM+z/o2VV+evjDgrK+hByNsz1WG7P/5wFT35LTN4W2o/jIcnP
         1AYDN2TS1WDKIgDZiHesSkaydlf6oR5UoVMHUJ0ANHyBxeOjji6PjKtatYgemiSLjorw
         ybmwRXBXzlglBwi18n532JKbf44aMhRHOsoCpgvJwsgyGSrzFiD5jTCGs8gaqVNIopat
         srHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726727965; x=1727332765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciBDeJbMoYShPX4NBgaU7Dv6KXNedCl1tbMLTbPne+k=;
        b=xHo5kaJ9/XMjteD+6yNPKC54WdbTirOtTY90B0MndGS8IKdrrz4LV9gcez+phS0qTB
         s7L3gFfcNaRx+gt6/v602PGAgs2uKocIUHN2bsxf7LfJjWbV+lSfn9RtBBjQNBX9agtV
         izj6zXEhi3chxhguDAD2dTwwqSF1vkvyCUhn07rEa7E4Mjx/ayg1/uQ67PQlFxldSUKy
         4XBB9C4mQJ7bo8jhK+5hqFpG11Cyi7O30/zXK+ZFnWYC1Qk66U/Si/hX/64+NMmkQwL0
         xGt4pM7Hs84/X0XfDIwLerAegr3vGxUEtS580lD4QPclaYmPhzokyibyTgSUrAVS901F
         tWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUA9V7ERcG3DPV6ifdqqF5HYdlfLlBteGzOmMUpe0LGvkwN4RlgoD7llf0mXn9srf50DPeo@vger.kernel.org, AJvYcCWxPVZ8s1ydQ1vDfXHqXqwplPk8dir2mbR6DS/eFAdMTYKax09VyTQEldUstY/kcdaO4Cwr@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT36xDErXf4a5Mpwph+MkZd3dyx56z3qnYRXx5Ct3VgVA0w9o
	dGpqedvbuewRGPMZ6e3OW+dFdwAxc4W9i8t1tDqZgD16hG0UuPiypTpJkUaow29vWj3uHVR+mTg
	BZa4x+zbOBe1RacIulmEcHTo0eNw=
X-Google-Smtp-Source: AGHT+IHTFEsMgb0xzYGl8MhnF2VcxUosQdj2CvtQ/OvDBnL7Eb5sTTXGpiv/plzMVm2V6OOuYAOL3prxrQoZvbq0PIw=
X-Received: by 2002:a17:90b:4f91:b0:2d3:cd27:c480 with SMTP id
 98e67ed59e1d1-2dbb9f7d558mr28967837a91.33.1726727964820; Wed, 18 Sep 2024
 23:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <20240917143402.930114-2-boqun.feng@gmail.com>
In-Reply-To: <20240917143402.930114-2-boqun.feng@gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 19 Sep 2024 14:39:13 +0800
Message-ID: <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 10:34=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:

> +static void hazptr_context_snap_readers_locked(struct hazptr_reader_tree=
 *tree,
> +                                              struct hazptr_context *hzc=
p)
> +{
> +       lockdep_assert_held(hzcp->lock);
> +
> +       for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> +               /*
> +                * Pairs with smp_store_release() in hazptr_{clear,free}(=
).
> +                *
> +                * Ensure
> +                *
> +                * <reader>             <updater>
> +                *
> +                * [access protected pointers]
> +                * hazptr_clear();
> +                *   smp_store_release()
> +                *                      // in reader scan.
> +                *                      smp_load_acquire(); // is null or=
 unused.
> +                *                      [run callbacks] // all accesses f=
rom
> +                *                                      // reader must be
> +                *                                      // observed.
> +                */
> +               hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
> +
> +               if (!is_null_or_unused(val)) {
> +                       struct hazptr_slot_snap *snap =3D &hzcp->snaps[i]=
;
> +
> +                       // Already in the tree, need to remove first.
> +                       if (!is_null_or_unused(snap->slot)) {
> +                               reader_del(tree, snap);
> +                       }
> +                       snap->slot =3D val;
> +                       reader_add(tree, snap);
> +               }
> +       }
> +}

Hello

I'm curious about whether there are any possible memory leaks here.

It seems that call_hazptr() never frees the memory until the slot is
set to another valid value.

In the code here, the snap is not deleted when hzcp->snaps[i] is null/unuse=
d
and snap->slot is not which I think it should be.

And it can cause unneeded deletion and addition of the snap if the slot
value is unchanged.

I'm not so sure...

Thanks
Lai
