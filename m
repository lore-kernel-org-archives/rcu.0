Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E55CDC9
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935389; cv=none; b=FyJBNvatft495RYG/KFk1YdR4bZHim86XTgXSGWUysyFq18B1L781rKjCTWWyosBRHD4uyIgh2hVnVvTgOZcphmNVHHnXG8EdYTDBfILBffwDiigMW14X34b2kdI+AAwl37Rc/OoM7ySpsUUDJPHKdm9C8vTwAihvMKgA4JcDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935389; c=relaxed/simple;
	bh=EzHSfqxnOLRibMIwnp5Bm4wGgfGaw99h6V/h/5KQlzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ifw3zv/WMJWPPk+Bvgahe4A6+7auS//KOC++2r0bTCgVIX39w2dYwZldM47eO7Y17xPXkbrPfmMA54T1AAlEHhB7U8woJGMeTWpYTcDmjDLlHd8dMkHairM/Ddd7QXwS0rYSO46a4M2RXsem2w8jBpd1Vw7idkR06Gyocx4sIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j55XPUlv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j55XPUlv"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22181888b88so1465333fac.1
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709935387; x=1710540187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCHYD7g5w02qkYJ98Gf28OBGdeZeHkIZNRO5BYbEl3o=;
        b=j55XPUlviEVLKH2bc4ty80LmbVYMWx+88vQ9P1flNKdf0RejkRNxA6un2Drbcsd/1V
         pEqyK8ab4zSFM/jAb/Z5vuqeXUcqOzOjMtdaMPLrwUm7HpapNuuNI1wEqB10NG12GGfT
         TWvUxqfhONr3u7VVKpWCPjDm+fG33wx2gJG9qBQP8xylq8oK1VBcEzqgJcG5DhOu+gwo
         OeYUIzXk5g+5LnBTwNhl3jNJPWRgd/pCgYbQN6eNSq4w8lw5qmLU3YHy3xzKujDw6fEE
         2xVb3tc13+x37JwdU36JT0k782iurX0OMQQFVHdOec51Xiq/f5vEDx8Uvlp7/ZUTUb2n
         uQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935387; x=1710540187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCHYD7g5w02qkYJ98Gf28OBGdeZeHkIZNRO5BYbEl3o=;
        b=N2YQST2UpZh4j6h6JIDSXDZNx7uYZSBqqcNNVhsYomnmFkwkvqw6ET1GUz/es4nFbH
         4eW7IpAT2X8Zms0tecSlB7IHJ742W2mgxlal+11zJnFTbP8SuzLeXUizerXdku36croi
         zUET1oMcNzXXqsx0GMohxOkckgt+QkqFXGBd/lANWLfYz+trGTGhko74OXwcAqxrDXaz
         sXxU5RCAryAfnE3hjnytAbJKb39Vwpt1sa1k05Z3oxjpphds1cCXb7Ss7mnBwXLRS0T0
         GsJCgOZXWkidi+BbRhXjq0rbCYnk0b8BrA+S31EQ/HkXoa5Na1P1DZPuUuGgD5fLMXhh
         kTUA==
X-Gm-Message-State: AOJu0YxTwoChQhWy4B3rW32hg03w0I0cNNbT0FsFdCccB2HFnMESh7XU
	pAR5TZXZe0VxPXXiz9cGiiJ/f4FO8y/qMO1/E9VN+6YzI+NMsYKLthQzzU2o8KRcnmXBKJqlLuK
	D0KrvsqVXJryuW1oWGCyc3txKG6+tfBswZwMF
X-Google-Smtp-Source: AGHT+IH5iVBool3MoWSlh+hgdMJeyjg5Saou0262pzE6qVeaNjHLHfYvWFZDO7hTB2f7KjIl75oOWWVbDlHlB/MXbno=
X-Received: by 2002:a05:6871:826:b0:221:864f:8c6b with SMTP id
 q38-20020a056871082600b00221864f8c6bmr414011oap.44.1709935387127; Fri, 08 Mar
 2024 14:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
In-Reply-To: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Fri, 8 Mar 2024 23:02:28 +0100
Message-ID: <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in rcu_trc_cmpxchg_need_qs()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com, 
	glider@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.

Because not all architectures support 1-byte cmpxchg?
What prevents us from implementing it?

> Therefore, rcu_trc_cmpxchg_need_qs() emulates one using field substitution
> and a four-byte cmpxchg(), such that the other three bytes are always
> atomically updated to their old values.  This works, but results in
> false-positive KCSAN failures because as far as KCSAN knows, this
> cmpxchg() operation is updating all four bytes.
>
> This commit therefore encloses the cmpxchg() in a data_race() and adds
> a single-byte instrument_atomic_read_write(), thus telling KCSAN exactly
> what is going on so as to avoid the false positives.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
>
> ---
>
> Is this really the right way to do this?

This code has a real data race per definition of data race, right?
KCSAN instruments the primitive precisely per its real semantics, but
the desired semantics does not match the real semantics. As such, to
me the right way would be implementing cmpxchgb().

Otherwise, the workaround below is perfectly adequate.

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d5319bbe8c982..e83adcdb49b5f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1460,6 +1460,7 @@ static void rcu_st_need_qs(struct task_struct *t, u8 v)
>  /*
>   * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
>   * the four-byte operand-size restriction of some platforms.
> + *
>   * Returns the old value, which is often ignored.
>   */
>  u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> @@ -1471,7 +1472,13 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
>         if (trs_old.b.need_qs != old)
>                 return trs_old.b.need_qs;
>         trs_new.b.need_qs = new;
> -       ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
> +
> +       // Although cmpxchg() appears to KCSAN to update all four bytes,
> +       // only the .b.need_qs byte actually changes.
> +       instrument_atomic_read_write(&t->trc_reader_special.b.need_qs,
> +                                    sizeof(t->trc_reader_special.b.need_qs));
> +       ret.s = data_race(cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s));
> +
>         return ret.b.need_qs;
>  }
>  EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
>
