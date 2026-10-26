Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792982199;
	b=xiEIXOKDfxqQ6D5fCbJRW0o5grjqqXGHg0ReVQkN3a+eggSjuMQD+hYvxG1wISGrrr8v
	 erzf+YOBUdHnczmJYBA4uZX7jBMxcArJuf5Xk8+zSsmVnPExsjnK02prSW8Hgba627DaV
	 oycyXWvX8kCuJCjAe4YFH+txJkRDqTxyI5CdH1ey8R4/3w+fDb+zcNI8MU0MtfZDD7hyP
	 eHrfkdt+bQQtrs2K5AoHR0+0N1irpwjkugl8GF30bybWEOvRPNV1DwFlfey8jMESPv5IG
	 6JFxfagRoN6sxXZwFcEe1/BJc1UoE4U+DeDPHVpAsI3WqzCUxZ/rrJKjeYw1J3fpnPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m7bdFtJP67PmJcIrwn/29KIkZ+QLRrIFYKFNL3qAIvE=;
	b=cPYi/n8GSgUC1/qR1SMeI6V0VpB2vYyjNbQkNpujrPJuEcbuHd/meYMmY5qqujViBz9V
	 I6UA0XvPiXM8IA7wUC95qWIE9HegooNMNWb6xg0Zkl/BvntDSbJlpIimCDa14G2shy5X8
	 dqdVDzrElcfcFDPE3rJ4G/HFX2MaZsJnIueQa/kfntWM4A5O78Fd228tDTIdetVYZc4by
	 BYOWECOAvY2mnwKTwFVUpHT3XQ6GCVj1c2yteQzdPl0552i+iuWOZVsYjFO56pXzXmL4d
	 cQ0vQbIZFB3OjYq+69eeL8Le/n2ahEOsLNVQQfWpp82v+1rMX3JAoFxFjw3arpGFPpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H56zD1lj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FA606A31A
	for <rcu@vger.kernel.org>; Mon, 26 Oct 2026 02:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H56zD1lj
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so18372585e9.3
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2026 19:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792982197; cv=none;
        d=google.com; s=arc-20260327;
        b=D1hyU/9Qk7lbuSBJWDkxhO+vlmzQBmLgY81zH+Y978QQcdcURs1vBWYGcZbXFOsOal
         qGiaAchfhnAKcacr2CJnBgoIcORBaZJiulBmhpQ2WT3DbkyBmPvtndEDKc8yl77Ohkqs
         TZ5qaBr9aQX41bT3cwby5Ewg+ktYvqoQpRIkIDEupqVUiBkLulcmoHonVzIB5d7FApMD
         RumNZ8QFoYaJdpnLweux2Q2cXTuEvxYF2/rKO/aD7OHbxq5et1vgb7Ag8al0oN8MSI0Z
         P8K6f5qJVpk10rxa1GuucojabjczEqDKQCInP/iS1lK5DLeQuIdJCEZJJJzyKtMln6fG
         havg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7bdFtJP67PmJcIrwn/29KIkZ+QLRrIFYKFNL3qAIvE=;
        fh=1UHMKQtkKiqvwz8qWhIa6h17ZjI5SG9xqRvG2hDTpI4=;
        b=QQIpvqhEocQeGTDLiIuGytoKjle2MwaKO4yio2ucqa806+/XioNP6qgO3K0vZUZfvB
         JAShZCR321Uo2ljuSJRR/BPUxZH1Jw2HbV5rGLvelkVyjf0WbWPFOtOz4YJodkeV54PC
         sZzBZuHkLYR/Veq7hCUybioyHJDbpSy3VKMZyP2iAoXDHjrla/bfXHvFbCPNMwg5mYQ4
         +w5t7B4ZcTgdiGezdB9kQrsZg6MPJFbCGRXzdq+sCmyU+eXulhcAFttJE7eQahytfLDl
         vEKQw37MwVsol3VzVkpxft+n4sJgAl8UuB4CNAeFNf/r8jGM8BJ2V+gVz4zlmfJqWfXj
         DnWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792982197; x=1793586997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m7bdFtJP67PmJcIrwn/29KIkZ+QLRrIFYKFNL3qAIvE=;
        b=H56zD1ljg6nalLm7c2rQvN4GUx6rNYneRDaac6bfGoSP8dBCWXlw48E3Nly2rV6rmF
         vsQtI0+XLURwSFo4lU8vbgD+gk6D3t1eOoGxjYxQ2l5qxoFIU317HH/FZxNn17CjFTc5
         FOY9iYajY4oM9hXIutL6GUF9tsBw02MP7y81XCLr3xuEGYcq9wY7rG/hEhMW7jjmiOIK
         0wTBESEgOCp7DPNR1x8YfEioQTlPYMhjsJks/zyUCEsxpxacGdYNjdBSqd82fa1aKwf1
         LiV1ADnh2RN8f21CSNoaqrYPHXNOuUrT3CuXdcKnDjiQC76Wpx0Pj+kUR6Sw6rytAucP
         DS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792982197; x=1793586997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7bdFtJP67PmJcIrwn/29KIkZ+QLRrIFYKFNL3qAIvE=;
        b=eURt6Qkx0Mi2tAueuRJdDqOXNrlRorE2IN1yVSm24mIQrE5qYvdRyvJ95e0TYzs7JQ
         jcSSimOLvvViMeACo+t1eR0L3z/zxsMwE3SZkbvtmL89O+Ef8GRRoGz/ATsdO/J1LSXJ
         FzkTAUqySibzLBYtAfXyNia9Y5Sv91+Msy+4LKXaEA9cak5czPE1hrVfn7kGn4la22kB
         0WMHJkgQjLhyZ8uKUYaT/mHfW7Bv88k03j72RhcTsgjIw92qBCw83+BiyBoJxH7JiqQK
         4a6FXrmvCMmY/JdACDNQIRKOVKZaFhfIg3s2JL/2Nn0eRltCwBrrTn1MROtE5QEEoMbt
         w6HA==
X-Forwarded-Encrypted: i=1; AKwUvBzJlou7+ECFioRyk74mzCVr82FFhRPgyhPkLnA5BJ21UK7JoRIWoWXq6CNCrIkQMvaLjLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIePDnVnkxzV5hw1bfmDRC51bZlM7dV0QKQDrWxo+uHGWWD9Fvy
	qHNivcRSyp1TFVzOmMb5pNAMF/I0Zx+7TlYdNMf/4WJL2suv+jU+es/tU5BuYRw3Y01ETSaRC5F
	RNZQMgIXmuFvH+TWFa1mZqwK55oqYcyY=
X-Gm-Gg: AYBFou17DgFczN/q12kfCKdvOaATjGcAKVoS9k2RA0sBVO0wBLW0YSiAKGwN98qM0Yd
	eEhDY+c/TWGjc2IuRfEHe0DVaOlymmioNm8PDzXLgQc/KjUXegNA7dFSSI1bb/025c0MBumK3pF
	mJPGmWn+vLjcwbuWJtzH0vAOEG2AQyEoZc6wJX87dRbiqeT8M/eh+tZVEXwIcJoCU5I76Y+LUbi
	mW6zMXquVTyQQRMexQr9TyvyPlboZbhFnVTmMVGXbDhnHCYrSJAiQBBQ3ZnY4J+ZQtGRDTOzWnU
	bp0x1qY7a5YfcofRU3wtQnZ8mDBqA6We1rJw8pidzy4+68uUAwOfEGmH6+/c+7fVxhPcak6g2mN
	+QZEVGVFtEP9CGku/9rB5stB31ngRpooHzc1UQEcP6eBEv/fgHEkTIqgJYOtY2iHTmv/BsHtV+Q
	u2CuUXsV4D1QtHRV7p
X-Received: by 2002:a05:600c:c16f:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4a35ac8c226mr89777325e9.11.1792982196838; Sun, 25 Oct 2026
 19:36:36 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-9-kunwu.chan@gmail.com> <384fa5e2-1cac-4ff4-bea9-173188d4128f@paulmck-laptop>
In-Reply-To: <384fa5e2-1cac-4ff4-bea9-173188d4128f@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 26 Oct 2026 10:36:25 +0800
X-Gm-Features: AclHuK8B25k5dqPJzw8ONzyOTgQYH4Q7lrxiBt9o0JQQPFEOY1Tg2UTbjen-WaA
Message-ID: <CAN_Opa_UiE9W3s1Y_NngjZKdy2vFm0=kk3oG2B9mdBX+L6EOoA@mail.gmail.com>
Subject: Re: [PATCH 8/9] srcutiny: Detect duplicate callback enqueue
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 3:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Oct 23, 2026 at 06:18:40PM +0800, Kunwu Chan wrote:
> > Detect duplicate callback enqueue attempts at call_srcu()
> > entry, before the deferred list can be corrupted.
> >
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>
> Same questions as for the previous patch.  ;-)

Same changes applied: pr_err_ratelimited() and dump_stack.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/srcutiny.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 98864977bed2..4400fd2b41b7 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/irq_work.h>
> >  #include <linux/kasan.h>
> >  #include <linux/llist.h>
> > +#include <linux/mm.h>
> >  #include <linux/mutex.h>
> >  #include <linux/preempt.h>
> >  #include <linux/rcupdate_wait.h>
> > @@ -178,6 +179,7 @@ void srcu_drive_gp(struct work_struct *wp)
> >       while (lh) {
> >               rhp =3D lh;
> >               lh =3D lh->next;
> > +             debug_rcu_head_unqueue(rhp);
> >               debug_rcu_head_callback(rhp);
> >               local_bh_disable();
> >               rhp->func(rhp);
> > @@ -235,6 +237,8 @@ static void srcu_gp_start_if_needed(struct srcu_str=
uct *ssp)
> >   * Also called by __srcu_defer_drain() to re-issue a deferred callback=
, so it
> >   * must not re-check the deferral condition.
> >   */
> > +static void srcu_leak_callback(struct rcu_head *rhp) { }
> > +
> >  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *=
rhp,
> >                           rcu_callback_t func)
> >  {
> > @@ -272,6 +276,8 @@ static void __srcu_defer_drain(struct srcu_struct *=
ssp)
> >       llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
> >               struct rcu_head *rhp =3D (struct rcu_head *)node;
> >
> > +             /* Bounds a node self-linked by a double call_srcu(). */
> > +             rhp->next =3D NULL;
> >               srcu_do_enqueue(ssp, rhp, rhp->func);
> >       }
> >       local_irq_restore(flags);
> > @@ -291,6 +297,8 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
> >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >              rcu_callback_t func)
> >  {
> > +     static atomic_t doublefrees;
> > +
> >       /* Misaligned rcu_head! */
> >       WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> >
> > @@ -298,6 +306,16 @@ void call_srcu(struct srcu_struct *ssp, struct rcu=
_head *rhp,
> >       if (WARN_ON_ONCE(!func))
> >               return;
> >
> > +     if (debug_rcu_head_queue(rhp)) {
> > +             if (atomic_inc_return(&doublefrees) < 4) {
> > +                     pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\=
n",
> > +                            __func__, rhp, rhp->func);
> > +                     mem_dump_obj(rhp);
> > +             }
> > +             WRITE_ONCE(rhp->func, srcu_leak_callback);
> > +             return;
> > +     }
> > +
> >       /* Record the caller: the irq_work's stack says nothing about it.=
 */
> >       kasan_record_aux_stack(rhp);
> >
> > @@ -306,6 +324,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_=
head *rhp,
> >               if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
> >                       WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> >                                 "call_srcu() re-entered during callback=
 drain; leaking callback\n");
> > +                     debug_rcu_head_unqueue(rhp);
> >                       return;
> >               }
> >               rhp->func =3D func;
> > --
> > 2.43.0
> >
