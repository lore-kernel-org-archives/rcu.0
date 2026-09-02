Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2D81ACD
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318338; cv=pass; b=dnDHDYUqGaA/dj46bX0XSq61jW3TPtRHGUk7DzsbL4RRQEYXSCoqf7yasROm64YYRsyQQjjVxDyXjkCZJecyRQQArS01pqnAi3zf4UhnX6l/sAqdw5RFLQWCde2Bk1CAl2moKGu4vEBST/cN3VsXJe8fJ+M0l0a0XXwfejD8jLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318338; c=relaxed/simple;
	bh=vG5TP0S/iUTd1J9BwHJfoMaTSPI1V3YxeOpVTTrEX+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVkZdgKk1IzVlRgjdue5W5qlcObYZIrRgJ2wwDn7dNLUowB3SwJKnxZY6J+zrOgD9ih6zHcOgJBkAQbCyin5fGwlbz246A0CpipgmhNrzWxiZNRmsCLhJQSXRl1OUwcegZ4FYgpbmlwrEywBGKgSH+k6iAW4ixdLLFV7LypXQHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRvWmvRr; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRvWmvRr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so5400955e9.3
        for <rcu@vger.kernel.org>; Tue, 01 Sep 2026 20:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788318335; cv=none;
        d=google.com; s=arc-20260327;
        b=qVmtv6nXph2xlff1GmugjKFtT01nh4ICHtCr4wiycBxfruR6sMvTW8PgO4X7fEOgYe
         fBPWQtrFijY+f5ApTGiaPit4k+dxPSTBsrXU7YdoL2coBXElsnfbWKV0ykqz/qBK3apm
         v7UW9qsttanjOWT7zHeiYMp94BC9JZpNRPhy/CEYUJfDJd4m2/1FRS0SUW/vH4bHjh5w
         H+DfCnRDTtsPPmcVc1n0z96Ci/T22T0l8qZ5Tj3HWmsqFyG4oydGZiyiY65ie5YHTBNk
         +mWq/MKvgkmeN4Gt9R90VJvztFHsoYt/ViMwwgoJQdFdZRnFxK1MwvMXLVFNtqRFXFWT
         gZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KG7EnJsbmoObT+0TdWPZhh+/cYQIM/viC8knuaGtIEE=;
        fh=hQhB60Djw39mdE52vceZU9MqaNHUIw3G5+HWt80v2Gg=;
        b=gfyqrV32WeYNVASzd6xPBT1g18IHMU1Bvb6Iowvj4VslDn7C8JUoLRqUqq8P69SkKs
         jK43NcyBlA83s0e0zc7/10p4wbD+t9nYbOo/Nfc/7v0bCy6zhB3jlG6RnpxICogA4S9N
         aQlYC+e6rwmUuF9Z/H7DKfNXxF1ksySZo4dBsg2FQh20/xH6/4edtgwSk6QlCkCHjv9V
         nv1MN4G7hG2jgboDe7JboeH0udHMFk3j9MANrCX385FwrZwzIsxqxgmDi52/8n92BR9O
         +wERgmZOSDa88iBP1ty1v3fxrjIkIvPjN3SMQke7Tj1Y9OGw7QBoJ4vS5wVAdb9chZUc
         5+0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788318335; x=1788923135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KG7EnJsbmoObT+0TdWPZhh+/cYQIM/viC8knuaGtIEE=;
        b=pRvWmvRrJkAemFasCgsMPyoR4iKZMLSkuv9J2eGSJ3SUQHxGg/vEllUBS0iB8Q1Gph
         y46LLCWosQvReVvrmK3KKszQJooy9lWRwf92XngtjW2KXBE9mcklucyJuPydy/nwq6d7
         XZ6LVBH6TNdDfLrMmkgNRyCPWY8GwNNkP/ufim/d+yfIrrC8NKBVf6sOBOcsKLkRkQ90
         n00QMS8CuQ6i780UuUZVw65XlFU0tiIBJ2UMrDKHXW7/RCZe+/MDCGxKxtbTMGtCX0b6
         OVfa3CbWUp33SuTrOYHKDFK6ssGFyzA8ET6gBUdz+LJEyuUgoH2XIPDpqxxReKHOCJo8
         l/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788318335; x=1788923135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KG7EnJsbmoObT+0TdWPZhh+/cYQIM/viC8knuaGtIEE=;
        b=fe17AmJgRvnyuKAzyrSsHvZ+UmRrTTDsCuCpE3eksTxc33Nf6ej44+cf3dFTnlVsT4
         Tzju7mjaJii2umhTBrfFWvRTnZ3WyZJvSmaNNd54Y9LqSmAVgv3omyq0uBrutwYLpzyN
         R1HhSw3pxMxvHDxCIKD6oxESt7ADLW75iEwO/jRjXLn4IWbShQSooGVGn3R9Vc7Hfhfw
         uf290WKHH1gt3+UD9FnQ1NLZUF/oPxPlBRRc1Z8XcUbM+XH0qYw4LTvjQrzNqEfeR5vA
         Ezwfh0VBnbPARcSrq3eksbnL0LtilgEr+tDTF0OfS56g7hEwmicocSgxtmOe63MArdYo
         plQA==
X-Forwarded-Encrypted: i=1; AHgh+Rrvm1AAv/RbZRw742FKhC8FYDLkFdx5SA6E3AuSXqJtFqZlfIPaQ/A4wiTMK99g0NgKIi8=@vger.kernel.org
X-Gm-Message-State: AFuF++nTV+S+w1s5ZUb4BMhb0knSOF3vXxUUuUs1YPptze9ufIMH7gHB
	wBVj6q0jgJ3cKLHz+6fvuH7ue2JBhXaGq0zy3rlm9k11uafkFNsbwT5WneTwbUmXWdMh3vna+KC
	0UC4+g+B88FK4tvp2K/quNrVs6Wy9olY=
X-Gm-Gg: AR+sD137obVpNJCKNp2gQrbsfHlD5Q2mcWxHY5afNNXGddi66GIdwygfBmKj7HFJ9vd
	4JILtm4NMQgb96YERJjF9EWMTKx4bQNptqTkVH0IPPc/VGZ6BIDaZXGuFZFslRnzT31OvtjxlXO
	cQOnLNibPaWwcbJ6MeaQQCq8HdKG15PTHVmPl7DSVJjYwgUNfVh/DapHAUkQXO61TB70Bv2oxoF
	v8GsLcvfHL+h7qcCdKeHKKmaiQvUzOSASUO04S3U9wbZlJOh8NZcOmFK6cLzQDZ2ua5XAsxplAr
	BLarbHdBGq2N9asgG/JZa8JvlBLycUb9iBTwe3T6mbdrexJ1keCAyvjc610uws+0ism7Nke/JX2
	/C1s=
X-Received: by 2002:a05:600c:4e87:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49ce580a50cmr18588845e9.3.1788318334582; Tue, 01 Sep 2026
 20:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831074937.2380914-1-kunwu.chan@linux.dev>
 <0eac36c5-acd2-4d8d-a498-f56a57cc3d6a@paulmck-laptop> <CAN_Opa_z4e8fLM0=+QV82r4oveKKUWitvNrBnsfJhXd+2-QQLQ@mail.gmail.com>
 <ce1789d4-7a78-456c-9e6e-e9af824e5285@paulmck-laptop> <CAN_Opa_AYw-KSA-u5=fjGLOP9z-Cf1Dk2Fba==MSLAX7TZSYWQ@mail.gmail.com>
 <e521bee4-e8ab-40a2-b22f-325d37fbcd63@paulmck-laptop>
In-Reply-To: <e521bee4-e8ab-40a2-b22f-325d37fbcd63@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 2 Sep 2026 11:05:22 +0800
X-Gm-Features: AcwNN1VRZhqUJfHSPfn4eelqT3qs28grS0Hldy6lTpa_ibslfPQJw1CVVla8bdQ
Message-ID: <CAN_Opa_7gKNuibT07tM=TcMYoTEzjeBO_=9WCoxVnY=-Jq2hcg@mail.gmail.com>
Subject: Re: [PATCH] srcutiny: Add atomic SRCU operation checks and state
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Sep 01, 2026 at 04:29:05PM +0800, KunWu Chan wrote:
> > On Tue, Sep 1, 2026 at 11:10=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 10:00:24AM +0800, KunWu Chan wrote:
> > > > On Tue, Sep 1, 2026 at 9:04=E2=80=AFAM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > >
> > > > > On Mon, Aug 31, 2026 at 03:49:37PM +0800, Kunwu Chan wrote:
> > > > > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > >
> > > > > > Add atomic SRCU operation checks and the associated state to Ti=
ny
> > > > > > SRCU.
> > > > > >
> > > > > > An atomic SRCU domain does not use the normal SRCU callback and
> > > > > > grace-period machinery.  In particular, a callback queued with
> > > > > > call_srcu() would never be processed.  Use WARN_ON_ONCE() to re=
ject
> > > > > > call_srcu() and srcu_barrier() on atomic SRCU domains.
> > > > > >
> > > > > > For synchronize_srcu(), redirect atomic SRCU domains to
> > > > > > synchronize_srcu_atomic().
> > > > > >
> > > > > > Add srcu_reader_flavor to the Tiny SRCU state for these checks.
> > > > > > Tiny SRCU does not currently set the flavor for atomic SRCU dom=
ains,
> > > > > > but keeping the flavor in the common state allows the operation
> > > > > > checks to enforce the restriction once atomic flavor tracking i=
s
> > > > > > enabled.
> > > > > >
> > > > > > Also initialize srcu_atomic_gp_flag, which was previously left
> > > > > > uninitialized.
> > > > > >
> > > > > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > > > > ---
> > > > > >  include/linux/srcutiny.h |  1 +
> > > > > >  kernel/rcu/srcutiny.c    | 12 ++++++++++++
> > > > > >  2 files changed, 13 insertions(+)
> > > > > >
> > > > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.=
h
> > > > > > index 47a368f945e3..2b293336525a 100644
> > > > > > --- a/include/linux/srcutiny.h
> > > > > > +++ b/include/linux/srcutiny.h
> > > > > > @@ -20,6 +20,7 @@ struct srcu_struct {
> > > > > >       u8 srcu_gp_running;             /* GP workqueue running? =
*/
> > > > > >       u8 srcu_gp_waiting;             /* GP waiting for readers=
? */
> > > > > >       u8 srcu_atomic_gp_flag;         /* Serialize atomic GP wo=
rk.*/
> > > > > > +     u8 srcu_reader_flavor;          /* Values: SRCU_READ_FLAV=
OR_.*  */
> > > > > >       unsigned long srcu_idx;         /* Current reader array e=
lement in bit 0x2. */
> > > > > >       unsigned long srcu_idx_max;     /* Furthest future srcu_i=
dx request. */
> > > > > >       struct swait_queue_head srcu_wq;
> > > > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > > > index 26ea4bfbeaf2..22f7716cbb0e 100644
> > > > > > --- a/kernel/rcu/srcutiny.c
> > > > > > +++ b/kernel/rcu/srcutiny.c
> > > > > > @@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct src=
u_struct *ssp)
> > > > > >       ssp->srcu_cb_tail =3D &ssp->srcu_cb_head;
> > > > > >       ssp->srcu_gp_running =3D false;
> > > > > >       ssp->srcu_gp_waiting =3D false;
> > > > > > +     ssp->srcu_atomic_gp_flag =3D 0;
> > > > >
> > > > > Good catch!  I will be folding this into the base commit with att=
ribution
> > > > > on my next rebase:
> > > > >
> > > > > 9a2e9996ccec ("srcutiny: Add an atomic Tiny SRCU")
> > > > >
> > > > > >       ssp->srcu_idx =3D 0;
> > > > > >       ssp->srcu_idx_max =3D 0;
> > > > > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > > > > @@ -289,6 +290,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> > > > > >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> > > > > >              rcu_callback_t func)
> > > > > >  {
> > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ=
_FLAVOR_ATOMIC))
> > > > > > +             return;
> > > > > > +
> > > > > >       if (should_rcu_defer()) {
> > > > > >               /* A re-entrant call_srcu() during the drain woul=
d livelock it. */
> > > > > >               if (READ_ONCE(srcu_defer_draining) && !in_nmi()) =
{
> > > > > > @@ -319,6 +323,11 @@ void synchronize_srcu(struct srcu_struct *=
ssp)
> > > > > >  {
> > > > > >       struct rcu_synchronize rs;
> > > > > >
> > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ=
_FLAVOR_ATOMIC)) {
> > > > > > +             synchronize_srcu_atomic(ssp);
> > > > > > +             return;
> > > > > > +     }
> > > > > > +
> > > > > >       srcu_lock_sync(&ssp->dep_map);
> > > > > >
> > > > > >       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > > > > @@ -415,6 +424,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> > > > > >  /* Register any deferred callbacks, then wait for all in-fligh=
t ones. */
> > > > > >  void srcu_barrier(struct srcu_struct *ssp)
> > > > > >  {
> > > > > > +     if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ=
_FLAVOR_ATOMIC))
> > > > > > +             return;
> > > > > > +
> > > > > >       __srcu_defer_drain(ssp);
> > > > > >       synchronize_srcu(ssp);
> > > > > >  }
> > > > >
> > > > > The rest is good as far as it goes, but don't we need to set the =
value
> > > > > of ssp->srcu_reader_flavor somewhere for atomic srcu_struct struc=
tures?
> > > > >
> > > >
> > > > Hi Paul,
> > > >
> > > > Yes, agreed. I have the flavor tracking changes implemented locally
> > > > and am testing them now.
> > > > I=E2=80=99ll send the updated patch shortly.
> > > >
> > > > I also have draft patches for the documentation and the fast path, =
as
> > > > well as rcutorture testing for
> > > > tiny atomic srcu , which I=E2=80=99ll send separately.
> > >
> > > Sounds good, and I am looking forward to seeing them.
> >
> > Hi Paul,
> > I=E2=80=99ve sent the flavor tracking changes as [1].
> > [1] https://lore.kernel.org/all/20260901074815.3145037-1-kunwu.chan@lin=
ux.dev/
> >
> > >
> > > I will admit that I am curious as to why Tiny Atomic SRCU needs diffe=
rent
> > > rcutorture testing than does Tree Atomic SRCU, but I will ask myself
> > > that question again when I see your patches.  ;-)
> >
> > You=E2=80=99re right that the existing SRCU torture configuration can e=
xercise
> > the atomic path with rcutorture.reader_flavor=3D0x10. I had prepared
> > the Tiny atomic torture test as a separate draft, mainly adding local
> > configurations for convenience while validating the Tiny and Tree
> > atomic paths. There is no Tiny-specific torture model here.
> >
> > I can adjust the final rcutorture configuration and naming based on you=
r
> > preference.
>
> The best approach is to add a section to this script:
>
> tools/testing/selftests/rcutorture/bin/torture.sh
>
> This would require adding a command-line parameter such as
> --do-atomic-srcu and friends.  The effect would be that people like
> me would run short tests of atomic SRCU frequently.

Thanks Paul. I=E2=80=99ll add an atomic SRCU option to
torture.sh so that it can be run as a short, frequent test.

During my atomic SRCU testing, I noticed that kvm-recheck-rcu.sh
can report =E2=80=9CReader Batch close calls=E2=80=9D even though the kerne=
l reports
End of test: SUCCESS with no WARNING/BUG. The atomic GP rate is also
much higher than normal SRCU.

I=E2=80=99m still checking whether this is inherent to atomic SRCU, related=
 to
my earlier fastpath change, or an interaction with the torture reader
delay. I=E2=80=99ll continue investigating this as part of the testing work=
.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
