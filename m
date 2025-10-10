Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F81D6193
	for <rcu@vger.kernel.org>; Fri, 10 Oct 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080776; cv=none; b=iHrrK63MuB/O/ziZzAtHOeJUJGND5nSWqGtFWf2u/01WVFKTsbCzhzamHN3VcbiJAzkhHkJhWdoBW2syDlqOEwUinEWb692VH943/PegRA3lcCQ3WV0L3Cu4JXmBCGta8MHNqwFiJnkTJdihHacVt5OJ5DT7w9HLEzFkuE2Jya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080776; c=relaxed/simple;
	bh=R3PKunh0BQZdjOFZ/HLfSIF2ZEogZJ9M3DyVyw+24+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+GoAtSko0eKTrdKfX3HoQYUFUIO74i0ziv0gpMWADGIadew2Ps2uq+Wiy3I6jpofu+tMSz/b9ZELy7jF2+7ofvpfQ9674fzcysUxt5qw7d5adqEfrQkUCwPcdtXi+WVd3TkZrbFQdbvq3j6YoHKViW8Tm1qyVTIL2oBraqQib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZyxcL5p; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZyxcL5p"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-87db3aa478fso156342185a.2
        for <rcu@vger.kernel.org>; Fri, 10 Oct 2025 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760080774; x=1760685574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLc40O80H6RjYakcJ8wdx7lSXcD1ZnkAb9zPDPfIcBA=;
        b=1ZyxcL5pfOsJ5r0x2TaM1xYVZkBPxn6lap/g+fMcuadBYCbWsv8VRG9DAA4GMUnejP
         RhSIdHBf2joIFBxSxBQm9kU4VLrWoS0/33HzwTtKybYPuK/Ezw5pcxNgLGT3MqKJfOF/
         s4TyJHjesBtrZXt2fy6aQMOaTJAEdYrEDwo6N4QYUCHsHVS9Lute2AFbLlQDD4OaYWo5
         ToivAmoIRVWTCsPK3OmOWhazftb+52GFFUZKkz3sviWFbyIvy4VmjJf3c6Sn7ym9Y0HM
         xd0EYKNhn/2JQif9URFA1lwsrGXTQF7+bO0kh6i/mgyoTgZZN4m6ICFBqYeVb0EyexJS
         Q6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080774; x=1760685574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLc40O80H6RjYakcJ8wdx7lSXcD1ZnkAb9zPDPfIcBA=;
        b=PdSdcsuvrVN6dxlz+/GUilNrVMM0rYiz1ZsO1vhaUz3CQSkC5PwlNbougjDX9tWpDa
         t5ehGQFLuWLWph+JlgsmwJvKAWZ+socQNyDCFGKI8psHRLsN/EJdNduSGooB9qYdITJ/
         eYxAKeYAvorOB3avbFaJimr5txatvNWvDZ4aA7xmIAQT1c4x3o/mXyJWuVhyFmWBdMep
         lMihVTesq/Hij3cqXg8tNZwlVJAphqtI4JMowd5woyzXSWNTUAgsYC2MFPyZI/3cB0Vi
         urP25ROhk/G2//4XMS1yWRx4vn4Xhciour8FE0z1C1GdmVXGmvX+Tc48nTZiX0G6SG/u
         ostA==
X-Forwarded-Encrypted: i=1; AJvYcCWLTMv7rgNsd+npEapWLyK+XcgEPM4l+q0bxR8q02buHkHfVqPRsgEW2raqunF7mkOh91c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFheZ31IAynMPbqChfHdQAskDkXjNu1MaE/Z4r0nB+RvAWG2jK
	yLv4DrtbWTd562nwgEeeGnhsmAbBMqTqNPlZTL36QA296Yyz47OXAIe1ZpObatQxKC6sAVyDVsl
	7NIsSJx1B5iCK+OfHAAY6P5tIrf1vZLesgIQJlIR+INWb9Q04l1o1/fIz
X-Gm-Gg: ASbGnct3CYqxSS0YRScn2hRzLDySh0mjqeCrBcj3HN+h6yRx3cu2UwxkQ8L7z1k0c7+
	9TFk9i5GJLh78EIAfgtoidmXCyZ6frFt+hIu4F3O+eBlDVM7vKh/tWmZsscqLr5LJ+17HNYRit+
	yYnoKevRFJIwIdP8SClSA8kD+feIJIUC5zrShw7saroLA1P0iXEl0zBzTZyBP0KwGAkehdl/iIv
	jzV3wFY9DlRXhcKUF8Zz7ZjiuFpYTys/A==
X-Google-Smtp-Source: AGHT+IFsh5igp0c32BfJgf290Q+O7VUVOOJPK8weyZj0C/wgs/QcBWCiWmtICBYLXN0gXLKPcmtcmHnrRqAGxAS3gV8=
X-Received: by 2002:a05:620a:454e:b0:85f:bd91:aeb4 with SMTP id
 af79cd13be357-8835088d613mr1701216885a.23.1760080773594; Fri, 10 Oct 2025
 00:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010064910.605653-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20251010064910.605653-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 00:19:22 -0700
X-Gm-Features: AS18NWAhyI7OdyXQTMWn1dC3vruwqYh6lnjW5jMISEbiXoRt3HCfgpTOu8JIbZA
Message-ID: <CANn89iKQM=4wjCLxpg-m3jYoUm=rsSk68xVLN2902di2+FkSFg@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: use WRITE_ONCE() for ->next and ->pprev of hlist_nulls
To: xuanqiang.luo@linux.dev
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, mmpgouride@gmail.com, fw@strlen.de, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:50=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> In rculist_nulls.h we can still see ordinary assignments to ->pprev and
> ->next of hlist_nulls.
>
> As noted in the two patches below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev fo=
r
> hlist_nulls")
>
> We should use WRITE_ONCE().
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/linux/rculist_nulls.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..d5a656cc4c6a 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hl=
ist_nulls_node *n,
>
>         if (last) {
>                 WRITE_ONCE(n->next, last->next);
> -               n->pprev =3D &last->next;
> +               WRITE_ONCE(n->pprev, &last->next);

n is private to the current thread. No other cpu/thread can see it yet.

Following rcu_assign_pointer() already has the needed barrier making
sure that _when_ the object
can be seen by others, n->pprev value is fully up to date.

>                 rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>         } else {
>                 hlist_nulls_add_head_rcu(n, h);
> @@ -148,8 +148,8 @@ static inline void hlist_nulls_add_tail_rcu(struct hl=
ist_nulls_node *n,
>  /* after that hlist_nulls_del will work */
>  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>  {
> -       n->pprev =3D &n->next;
> -       n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> +       WRITE_ONCE(n->pprev, &n->next);
> +       WRITE_ONCE(n->next, (struct hlist_nulls_node *)NULLS_MARKER(NULL)=
);

Same here, n is private. No need for any WRITE_ONCE().
