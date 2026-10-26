Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792980152;
	b=NCPI/JnyUyq8MFEU+ruGLDdR18nG7dCMIueD+vNWIMvExaaAlHR3Amd4qJ0JboULBrwO
	 Vgn9JLopz8zbse4ujNqjQJPRVs5kVtpl6iqWKUwwsyoQY6bte90M7XOOecgynJOeNMvbQ
	 0goAHQ558IlAC/yMy7pPUCdXTqkh+tOcukgXquuWY/tn5+HG2ch5qip5flA2X82b/zn6a
	 J6tAW73zZdPmKGDqYFrVM7ao6LJlsLxthaiDxuGTgwdln1M1YjV/4LXPIaRzOd5zXULio
	 QToRovmdDL38rYMfpWMHP1Xi63bhzW1SDwXYEIds9pmsJZwGi6RmybFG8i2K5YvwFIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t0CJXdu2WvJswBCkzhrCpBJfhXZWXSL2ZyWgfmtZNMk=;
	b=erLjUIctIdhiMxoo/5MH9Y4jjr7j4QPqTJI++xp/GWWxABOM+EJzo25OhTcKByRSL0cC
	 MwlqMdb3HCLaoEh4hDSseeFowrcXPdS8gGSZzuvD2JnAB83Bs5UnyYshMcn1n03+36+mS
	 3+AP2kyx7FkKDZP5Gznffsl/cqUJnHYb2vK6yIsZLDpXfYCGEbARrpGgIA6Og7SfxSmBf
	 G0Bue6ELbMeH7Nb/U5GZe5+txxHcC8q5BS97etDQX4muvYHA0/GlrZEsLrZiL65lhVDXk
	 XHPtYkoXC7gdclm/h/8d/nOnOz2A+F5HTjxiv/yQ1E//06Uur6eB/oQHv8vlryRH5SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BU2bBXlM;
	arc=fail smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC217606A31D
	for <rcu@vger.kernel.org>; Mon, 26 Oct 2026 02:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC217606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BU2bBXlM
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso11481385e9.0
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2026 19:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792980150; cv=none;
        d=google.com; s=arc-20260327;
        b=WXU4Eif7gJSduRbgtshdefuJKmuuWZ22Nb1KCUs4nrrDOf6S0AWemHY+h/d5bRlbe7
         wswqaGL2OMpv0VPdSytq+5YSY+1v6tFhukfIHCvIwGeeO4O4z/YzYS2TtMG4kI4sqjQD
         o6NHyzd8Oh0DBQ1TGL7RCbNSiagCDPQl/m438sUYEsmIf349dD5nEwJmPRiVehqnwamX
         KorgXDOW1Q3tSiDlFPe8TkW+fEubD6QYP/VhEH9iJi1apwvpInoh9hkVAvO5Qp6lYWv/
         KaigMYOzor30DbqR0msPNfVB/bFYGmUMs3FLuWb48UouT0TOgVjBgiCZ7UJgIw9EJZ9a
         5OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0CJXdu2WvJswBCkzhrCpBJfhXZWXSL2ZyWgfmtZNMk=;
        fh=W3eeQrk6oeDhJZtCh7vdAkXbS/KUmAF2MB9rZLoreNE=;
        b=p5E6BQV+xxa0H2NjlETHeCYIt3g4fLeHSPnu2rh5CvCfsAp3Bmb/TdW3sYBx+m+gV+
         hla12+3hm/w00XQgn4J7G4PJQwkWqdA89Tft9P+Gl+XMBkdQo0/Q9QTZmZzH162PWrcs
         It8rJei7y059rXLQVa+1+ghM4fr6EWiZzkqn94g57IpftTNYRWUV5b00JKQERiPJTT4F
         Se3DlGexgNTK1k5XmoFMTiewEvvz9aBfpP4CLsya/7odeoztZaWxpaobvHe2eKI1aCgN
         iRHtfLclvSEgUATgRjXLezAchfVGNODm4wc5B/qXqIMyKJruyiWd21jQGsqQy/gL6nZt
         CfeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792980150; x=1793584950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t0CJXdu2WvJswBCkzhrCpBJfhXZWXSL2ZyWgfmtZNMk=;
        b=BU2bBXlMIMOBsdtITAutKT4CP7ymX2MVgduiijANnolzYH20SxfRwfbhKIiIaDMO7e
         0TEmRSfGLW5FdcnNVcay1bmqqh+Lou/SfByA/GSIFW1nJeCnAfzGDPRUsZiV1TpgloAc
         CY/lzNgZhXjGmfiym427FflSMhE5Wwf2GyJ58tUMbR8YXJ2NFfzsciIgY4YFer+xVC9B
         qrPueRmFxtS4axzOGFCOXnBk90OJ7oT/6aG20j5QK6EpfRc7I5vn4TJFW5hi1zCFJsET
         s4VKU6sE+B6K1tlIgh3T3MOj0OLgyC2AkfkEf5/Palf9PuSPsxV8pi3//zqMNS2TUxe2
         0cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792980150; x=1793584950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0CJXdu2WvJswBCkzhrCpBJfhXZWXSL2ZyWgfmtZNMk=;
        b=loMUWfaR7F2vrX6dABtXnEd/XqwheTN00ZynbmYKT8QChWqndJSao/7DESivljUfK7
         dQ7OIaLDMvVIGnUmdOQJJ3MShAYkFfJf8mPYBnB6ole4Sz+ClttSbQxWlRbJJMyCy0Xq
         iPjSj3csubJPhkj67B7vPlxb5RFQEWJMKfaAEeXwUsttBoTSLYaw0NYWXQqjbQA+o3Zg
         SV9nJqK2D+8IQYNrCxWaUUtBTzFjtIjRIncKVuq+Vk3hJl3IYzaHwCbbAahbhv8MWAVW
         iaRr9jNPzEJAeD8yoQcNpm7V0gqWiuaub/7X9G/xHmCH9najPOx+t6qJcCVR9bGS6IpE
         p/zw==
X-Forwarded-Encrypted: i=1; AKwUvBx7LNZ7RUgaElylUEoAYZtbhQp0khYGmLXYjx2YGnvl+J9JlrnNon2Io1ZnnNdmReiTOPU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/Wb8T400c6wdwGNnfikPbnzMoe8lX7vwK52GpjFBUNCNh33qP
	RNRN8Wfb+5S9zQUPYlM13GDZonA7SDTweFZE4JWd+ZKTWTTdEJX1c2+GDzlYlrCx1qw72K75SPL
	qOFyvCzuCHo60yv4plpI5J/VnoPNjXb4=
X-Gm-Gg: AYBFou3qzgPGCqaI85YVOJL8Ytl6Eghownry85wIFudR8AsaPxYz9l7hYppNex6PoVB
	e29WfPVXrtPIT9Uk8ro0/fISbeoXeJquIzgF6u+I0XIAMkR7rmSTagVQk91SW18JuvQdbQumnvc
	FykdXGuPml+DHPd/UCHu6YBTEJF09dwbb/tn1NDvuO89f2+TDxW1ofvb9VWMkoOtvrOvn5YBKc/
	urt06Yt8sWYFKj6y08XNBNtK/2YKfNuX0j4ehyRj5H/oZq8xwcqw/b0oxfqXEANwWNRAMNcW0h5
	16ORsHPhUqHuFC4rnp0kdMZuS8D6Yojs9FpIQHa+3ELR0E0pDpFGBRrz1+TcSlyx1hyaCv10WXv
	OvSthlHfQMAtCJhb3IzClJRLQg9oPIMeMLoR7Xd1F0v50uNCbpK6Lj6Gcwmmj3ZfdJxgOTg==
X-Received: by 2002:a05:600c:198e:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4a35ac9d1c2mr108316275e9.6.1792980149797; Sun, 25 Oct 2026
 19:02:29 -0700 (PDT)
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
 <20261023101841.2910719-2-kunwu.chan@gmail.com> <ee221d82-c064-4db8-bf85-3acc2e70b983@paulmck-laptop>
In-Reply-To: <ee221d82-c064-4db8-bf85-3acc2e70b983@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 26 Oct 2026 10:02:18 +0800
X-Gm-Features: AclHuK_r8Qh5VqYW8mGbk1vYXEbW83hcBOqPAIwNMkxZsLHjr4eexVTG0QM4lCc
Message-ID: <CAN_Opa-qWaG6aminLu6k2Wn2iCBc_fLKFRmY=dpHEX3XuUwwyg@mail.gmail.com>
Subject: Re: [PATCH 1/9] srcu: Record callback registration stack for KASAN
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 3:41=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Oct 23, 2026 at 06:18:33PM +0800, Kunwu Chan wrote:
> > Record the callback registration stack in __call_srcu()
> > for KASAN diagnostics involving SRCU callbacks.
> >
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>
> For 1/9-3/9, looks good if there is a kasan_print_aux_stacks() called
> somewhere from 7/9-9/9.  I am not seeing it, but then again, I do not
> claim to be a KASAN expert.
>

Thanks Paul.
kasan_print_aux_stacks() is called by the existing KASAN report path
in mm/kasan/report.c (describe_object_stacks), not by the RCU patches.
Patches 1-3 record the aux stack with kasan_record_aux_stack(),
and KASAN prints it when reporting a use-after-free.

I verified this under QEMU with CONFIG_KASAN_GENERIC=3Dy.
The KASAN report included:

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 call_srcu+0xb2/0x390
 test_init+0x71/0xff0 [kasan_aux_stack_test]

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/srcutree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2b0e2b2d2c18..46fe2f0cef85 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/preempt.h>
> >  #include <linux/irq_work.h>
> > +#include <linux/kasan.h>
> >  #include <linux/llist.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/sched.h>
> > @@ -1530,6 +1531,10 @@ static void __call_srcu(struct srcu_struct *ssp,=
 struct rcu_head *rhp,
> >  {
> >       if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_=
ATOMIC))
> >               return; // Leak the callback rather than corrupt SRCU sta=
te.
> > +
> > +     /* Record the caller: the irq_work's stack says nothing about it.=
 */
> > +     kasan_record_aux_stack(rhp);
> > +
> >       if (should_rcu_defer()) {
> >               struct srcu_defer *sndp =3D this_cpu_ptr(&srcu_defer);
> >               struct srcu_data *sdp;
> > --
> > 2.43.0
> >
