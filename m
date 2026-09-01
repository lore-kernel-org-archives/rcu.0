Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C63D5679
	for <rcu@vger.kernel.org>; Tue,  1 Sep 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228052; cv=pass; b=i0dtb9sFmExqePMmrGiWx6qaFD2cBWHn/g7Rjv//gPZchjuLsKvEgny1i2F6++Ni8hv2L6CPOInqTaLl/vAxq2sNkmad5UHauqLyF7HUZAObLoOvWC2rN6JWe+45JmZ5Mg22Z0ogcKMKG/tNOMtrbddX9lIiIjsahA8ubgqK4rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228052; c=relaxed/simple;
	bh=CQQWiaaK3VZG5SIKWhlGIf/hiXPva8fyQeQkJCDkw14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfPX0zHfCwbjG5SSyVHg+ZzrXBBYHFm1TDSOc0yleXyQhYnmMGWb021aiaiGwWl7M16mU6DneWZV6/w0Q0lpX2fVKPmdbEs+xfx8YNdkb8stiT8NDuvRs/dXy6vo7PRyQIlQxsCqg4ULzlNcmyh4CKM2TPuMiSPsP1LJgLplufc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihOo7XUG; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihOo7XUG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so3249875e9.3
        for <rcu@vger.kernel.org>; Mon, 31 Aug 2026 19:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788228037; cv=none;
        d=google.com; s=arc-20260327;
        b=fW3crmhmXORmosy9CFK1K9y06tTGuHnsgR0SlF4ahhcw620UmAnwesrHKj3jUqvxpE
         UvFN5H68IA6pLoefdgS8z2Yrrk/ClweDynCqG9uzVzBf1FE1ctdojgTE4Vk5VXYggau0
         iosHkfHaYd8S6BJCtsTZGBoGyz37H3wnQDCC5r0JIOIndxWSf2tw7k9EBcJty75P95MB
         GBPZ22SsdWvd7ESKIAWwSJn7/v0lv7o35B4B9z0aLeNxOVnMZR3nlpWl6l7/DMrsGqQ2
         OYdLm7HfBVDM5hJLxGF6JRuLXbyBeHjJacsmgw8BhjojhpJ2CvKkPpoWyv2Yfh0ylqin
         VRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pO/folBnV5/GMkSd1hxgT/7e0hMo94czuPGpwnyLjCc=;
        fh=AlU+/D87DpeOVjPmsGzrVuRrGtXVbrBzrW8EEEyH8e8=;
        b=XagBzeeRXKAhcb9bet3ChdtiXeJiRNSK7S84Eu/Ol7NGnISDOkHRbWgqDMtPXGSPm7
         kFgpuyqcUvI0OPGQnWOCi+ZZb0CaiJmQ9dRmP4tzozZ7Q5na4aXZOzRCNxmnGD8+P1uu
         SOYFROa2ud/Wm3DH7z/mPTOIUyzJBP71iKZkF8p4Dt0ZmndaUYYvgtrpkqzaYgVFCIBf
         3dXrmWQow2tUJJG1RzyRiOGRHiOfhgJdrOV2oegtOzQo27DJLrs7wWwK6AV8G9N2Ffq0
         tKK5E1Vx38N94ahdooYOa5ZxnREx0JpWYQGBgrYOQ8Kdb9V6A0IbN/EB20IV1WTyq5ht
         v9sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228037; x=1788832837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pO/folBnV5/GMkSd1hxgT/7e0hMo94czuPGpwnyLjCc=;
        b=ihOo7XUGawuzhrmCi0eDrS2Ph4bcWZ7N7GLCG4fF/SBzp8RlziWQV3zEmxXYhv3khB
         re9mTptRlLofujYcre6afqjc2ZPw1g4/YWEZdDKCqAnB6azzz0BrZzRpa27LU7LAKff6
         G1G7gh1iw5eFA9CuOyDIVjHNUO3jyDmZubqtkjMhkEuk4yhcJjVHOadpnkgOPMuZvwIR
         W1j2LhOX7LGp4AI45DJKLVzT7TGuw7sreeutQskOJmVrdXfum1MlyihwHyeQNoJf3zA4
         gnfiTfx9H4bI4B3put0NVsxIA5ni/QDHGzS9x3VY6/MZHE2Sly/k08LJxPsOybIFZMgL
         bBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228037; x=1788832837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pO/folBnV5/GMkSd1hxgT/7e0hMo94czuPGpwnyLjCc=;
        b=h0D0r/BckcsIsqQ2OcdbGTmFl90EBYD0O0aXysWI80OhpdB8WAQcHC02jJrgp7KwKk
         NGOPtHXkgtey7kDIle/ZGQu66Bo8ZSAztcXvmAKl69+RsG1xog7tGsfz96O52R8vkkaR
         9A8/NXyyy9R72bxMxNle9i/ZOYGRzlhZplJ5CXkXcJB/i+BoT6Zm2ZcQncHHfwR2Z4jr
         I7qjFvZmp+1cNt3qLAWJz4o51ZT7uiGlO4HTRmbZNU0oQHXG98fQok5lYhUu+bOxAGVu
         Q8qPDeoUcYxYPbePQo9wKj6FtLTTLw/YSBEPFPYIc7wiQfxza3fkXihL9Zo6IRFfScpz
         7WRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdJeCC7UZVykWxEEDsR7NZ8dEkVc/GHjdn9qp1RFprJmxGeNoZ73nYOz//ga7fNbTCFYk=@vger.kernel.org
X-Gm-Message-State: AFuF++ku8X5t2IASm+9+UfgWUFdYYMoDXs+KVsWDen/J+d+W0rnCNmcQ
	b0Cdp+zdfp4nak/e5VyQrloYDcmkt8Fivp+RIe6OP56MZUmu1lllRAu/H7r5jBOWiYQyTaGwvWu
	F9h67eTK7FWy1Wsk9SVx/BvDrR3KtzRY=
X-Gm-Gg: AR+sD102OIkF/BOg1jZZplJZuuJYS2cveV/fSIDsrLqmLC2lBQlU2aKaN+NrMoFxb64
	oqaY+70pMTmX0YsCtEl+8ybAqWshJp9KRJVI7gqH8GEa1ypsotCT97dIJKLdTjnAXJipDF1ueHQ
	CeRrJwc3NuSmRmhLiAmODRX2Hg1938j2ZX+GRwBCLbfcr4OuMmyIq+2UdhyQxi6cFHDRY2eZIXm
	rF5izhebvaL1FN9sNtkNA8zddJs79/NKIbnakLq4Y4/5+/uC3Lwqi0h3mGkCC5kZ4NtCSCZs5Ba
	k/FSnDhx+ln6dmMg9V/y/JnLothV98ExKq1hq3uJVgzbSnlN5pKx9OfoBTLgFO/g297IfXs3NGO
	tqxI=
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr490001255e9.6.1788228035959; Mon, 31 Aug 2026
 19:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831074937.2380914-1-kunwu.chan@linux.dev> <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop>
In-Reply-To: <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 1 Sep 2026 10:00:24 +0800
X-Gm-Features: AcwNN1VlRz612JSdd2q2k981jRzkyP1IJqbw6xTF6MxL1_nMg6jtz7DSvFJWt1k
Message-ID: <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:04=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Add atomic SRCU operation checks and the associated state to Tiny
> > SRCU.
> >
> > An atomic SRCU domain does not use the normal SRCU callback and
> > grace-period machinery.  In particular, a callback queued with
> > call_srcu() would never be processed.  Use WARN_ON_ONCE() to reject
> > call_srcu() and srcu_barrier() on atomic SRCU domains.
> >
> > For synchronize_srcu(), redirect atomic SRCU domains to
> > synchronize_srcu_atomic().
> >
> > Add srcu_reader_flavor to the Tiny SRCU state for these checks.
> > Tiny SRCU does not currently set the flavor for atomic SRCU domains,
> > but keeping the flavor in the common state allows the operation
> > checks to enforce the restriction once atomic flavor tracking is
> > enabled.
> >
> > Also initialize srcu_atomic_gp_flag, which was previously left
> > uninitialized.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  include/linux/srcutiny.h |  1 +
> >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 47a368f945e3..2b293336525a 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -20,6 +20,7 @@ struct srcu_struct {
> >       u8 srcu_gp_running;             /* GP workqueue running? */
> >       u8 srcu_gp_waiting;             /* GP waiting for readers? */
> >       u8 srcu_atomic_gp_flag;         /* Serialize atomic GP work.*/
> > +     u8 srcu_reader_flavor;          /* Values: SRCU_READ_FLAVOR_.*  *=
/
> >       unsigned long srcu_idx;         /* Current reader array element i=
n bit 0x2. */
> >       unsigned long srcu_idx_max;     /* Furthest future srcu_idx reque=
st. */
> >       struct swait_queue_head srcu_wq;
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct srcu_struct=
 *ssp)
> >       ssp->srcu_cb_tail =3D &ssp->srcu_cb_head;
> >       ssp->srcu_gp_running =3D false;
> >       ssp->srcu_gp_waiting =3D false;
> > +     ssp->srcu_atomic_gp_flag =3D 0;
>
> Good catch!  I will be folding this into the base commit with attribution
> on my next rebase:
>
> 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
>
> >       ssp->srcu_idx =3D 0;
> >       ssp->srcu_idx_max =3D 0;
> >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >              rcu_callback_t func)
> >  {
> > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_=
ATOMIC))
> > +             return;
> > +
> >       if (should_rcu_defer()) {
> >               /* A re-entrant call_srcu() during the drain would livelo=
ck it. */
> >               if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
> > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_struct *ssp)
> >  {
> >       struct rcu_synchronize rs;
> >
> > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_=
ATOMIC)) {
> > +             synchronize_srcu_atomic(ssp);
> > +             return;
> > +     }
> > +
> >       srcu_lock_sync(&ssp->dep_map);
> >
> >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> >  /* Register any deferred callbacks, then wait for all in-flight ones. =
*/
> >  void srcu_barrier(struct srcu_struct *ssp)
> >  {
> > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_=
ATOMIC))
> > +             return;
> > +
> >       __srcu_defer_drain(ssp);
> >       synchronize_srcu(ssp);
> >  }
>
> The rest is good as far as it goes, but don't we need to set the value
> of ssp->srcu_reader_flavor somewhere for atomic srcu_struct structures?
>

Hi Paul,

Yes, agreed. I have the flavor tracking changes implemented locally
and am testing them now.
I=E2=80=99ll send the updated patch shortly.

I also have draft patches for the documentation and the fast path, as
well as rcutorture testing for
tiny atomic srcu , which I=E2=80=99ll send separately.

Thanks,
Kunwu

>                                                         Thanx, Paul
