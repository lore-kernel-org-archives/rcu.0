Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62310A3E;
	Mon, 21 Oct 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729554664; cv=none; b=RUE9QwKIvO9Q0IM2wtaDht5/FepH0R0ZZzpeGTl+mca3DVbG5czWepWVcUZmjS6HAawCLf9n+pOcukM/M6+GUDv/8xPS5SZtzF3QD4bXC99dGESGxzE9TzMlS2tTQw7jlJU8EfSAKmm+cnumRTRvi+HAZNGKX7bDHsOqNxSrD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729554664; c=relaxed/simple;
	bh=93xD4Tmdxtey8zA31B+sDxPb2lgtp53gthKrr3LUyrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTOKGX3iz2KfwaPsGCe5CvNAzgpOJqbm2rbF9PlfAWpnzOevmPem1xHLGU+M5OQyoO1HirUEsVaUlcRPU//g4N9bA58BpPvSNxprjs2qt680MWpR4DHtmYi1sJcGCN1w9htdM/ShmaINKESJvhSw19apt1ujktHayQUUqdaDo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbJmDbix; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbJmDbix"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so4250318a12.0;
        Mon, 21 Oct 2024 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729554659; x=1730159459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DsstOehMPTk25wTqFefncYy9YI2o+RkqFZwG3Mp+20=;
        b=mbJmDbixVKW4qVbvRTFDYfZtC8uFMX5C2SZnB2hoO7sc5ZYMLpHc7ON+HPC6rywDLv
         B/8bmnv3ox596YP7zXlOnZuZWIhV0RatO0Nw6tBvtgiVaqzmz0kBHzqaHKPXUGAln5Xd
         iZZZfDwfhvwQfYRAUlaFHUxR78gZYQM46f4fzpNXsHmCVJFRk5IS7dbDl79FzKyjlkzN
         lABEfFdSiWTPOGys3VztgqXGFkSqORnxD7KJ4s8TybtVaMrZyHAldcTUZlyt4I9HfBJx
         jqmtwoypyfdNu1BE0Dg04HQUkUflokRouGFX8gBYe1lyaQpjQbT+zTXWM+vJ38o0nZ75
         to9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729554659; x=1730159459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DsstOehMPTk25wTqFefncYy9YI2o+RkqFZwG3Mp+20=;
        b=jRnLUieqNMXviUTCFh6dW0Ef85t4L0PJ7zNax8Hcl60ukCPESBFcWDUdXzgs2uwoUT
         qcIWWdWnMFj5Z/3icMQDHyqmNcSFIZg7dw2iPGdDWLsLh97K4BLfKj98JH1H7XUH+IeB
         cFcAFHYFE7FmTpGsf/X0VtSk/bLGBYHZGo9Enn4fZsCsvKNMIvLBlzXYc3+zRR9A27px
         2pfUxs9145RR67gIVyDcIfZ69JokhmsqwdKum0YOl1hh7pq7Wcadd4e8ir61lq6gEukh
         9MQJ604W7ehB0E5ylG83MGPvYcYyxqXLCI7A7M1WBaGLWPuXGKzEj0DoIUeAZwGeUDLX
         UBqw==
X-Forwarded-Encrypted: i=1; AJvYcCUz/QhZbAy4yQohNv7pgMrUBYXYpOtJ59NaFNA9fZUtffnKk8qDHNcvS5cz/NMJbpa1FYuLTN1rMuSU+w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2SZV/HdTgsqN2LJpNHN5Tf1CPDwmNcxohc9GpcuaEB+RZvWj
	JU/eMKqKAX24eiu0cWqQx/8Y7fCiIozEsvjEd2LjaaTudqd6vfhIiKp+kfvOgxKgBKrXZJblaH8
	r7cIC5pzdIPWROnpxuE0ydIZne2Y=
X-Google-Smtp-Source: AGHT+IEzDjVyVWT29AJGbIwG7b2eflJUodQhWYTjVwmzTK10zwWUN+8xkMDjNVQIaTnlgDUgrc3HbwPS9mkt07D9sfM=
X-Received: by 2002:a05:6a20:ac43:b0:1d6:97f2:71b4 with SMTP id
 adf61e73a8af0-1d92c4bac83mr19878033637.1.1729554658722; Mon, 21 Oct 2024
 16:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
In-Reply-To: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:50:44 -0700
Message-ID: <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:13=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> For almost 20 years, the int return value from srcu_read_lock() has
> been always either zero or one.  This commit therefore documents the
> fact that it will be non-negative.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrii Nakryiko <andrii@kernel.org
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index bab1dae3f69e6..512a8c54ba5ba 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp=
, int read_flavor);
>   * a mutex that is held elsewhere while calling synchronize_srcu() or
>   * synchronize_srcu_expedited().
>   *
> - * The return value from srcu_read_lock() must be passed unaltered
> - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> - * the matching srcu_read_unlock() must occur in the same context, for
> - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> - * if the matching srcu_read_lock() was invoked in process context.  Or,
> - * for that matter to invoke srcu_read_unlock() from one task and the
> - * matching srcu_read_lock() from another.
> + * The return value from srcu_read_lock() is guaranteed to be
> + * non-negative.  This value must be passed unaltered to the matching
> + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> + * srcu_read_unlock() must occur in the same context, for example, it is
> + * illegal to invoke srcu_read_unlock() in an irq handler if the matchin=
g
> + * srcu_read_lock() was invoked in process context.  Or, for that matter=
 to
> + * invoke srcu_read_unlock() from one task and the matching srcu_read_lo=
ck()
> + * from another.

For uprobe work I'm using __srcu_read_lock() and __srcu_read_unlock().
Presumably the same non-negative index will be returned/consumed there
as well, right? Can we add a blurb to that effect for them as well?

Otherwise LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>   */
>  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp=
)
>  {
