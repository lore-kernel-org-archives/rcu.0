Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322519F12A;
	Fri, 11 Oct 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669448; cv=none; b=gCT2jTPiAE/ohDya7h1gT2awTFQHu0oMdbXE1qzPTo4SxuSyNPbrrI3JudTkb/XftkDSx+n4sAHpUZfWvS/H9N0C3FS15/o0b55ggDNymvl+VWhLf/9GgOEfaeYiLf0OIUWixUeE5ag9roJf3J4rsDiSOiObmrfvWCaFs0DcM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669448; c=relaxed/simple;
	bh=j1QLahTfEQQSYIMP3KE0A2wTk3QESAmjCUFpyaDKofA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G86rDu7R7R682+ly5lhmrCRl0rUMRfi12Z0oPw78NxBbYFwft0t/EAIiLh3FdH2R+PheTEOzzZEsXnFdRf5Rp/mRLe+6cv7T5Mz3ANUrFOqiUMBuCYM5yxGhX3EFWK/jsmsnydT8dztH3Qolo/3lPkW/WvmcXagQAyOd7plzrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/mBhOeo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/mBhOeo"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so890555a91.0;
        Fri, 11 Oct 2024 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728669446; x=1729274246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBjSNpLEMV/nmiVFXcbKDzRKa1TywIogtOvve4dQ//s=;
        b=h/mBhOeoYXCG9vkcQ4zmj/t+V34HCr0KBNVnFu1Z6nsuHTvX7fRL5N8hajBHnGhP+m
         8oMUp/Ci4mo2mhQjkcSqlg/uYJjm37geZPQrMN9cCzH8EI17HDDdQ6FTIsAJHB8QiCaG
         KO1An3UrHzsxG3hPsagncfubl+k8Pu3O/A2TCIq4rEI+XPMRqK8gJU+6/T/llHedZvFb
         bh9YGuulQPVkRjAp70Q9bAggLUildG8u0lppVJ4IXsFSFz9jStyaAZvk0IJN9S2h2YAt
         K5v9JliUI2aWZDmeKzbnou8tHpG7n/oU08Jpp4RR7sqcG8OTcLLNTabGWlModf/JnoEo
         9kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669446; x=1729274246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBjSNpLEMV/nmiVFXcbKDzRKa1TywIogtOvve4dQ//s=;
        b=gDicSx8i23iRuiDmyd+oVjbTVZcSlPnujBHL64bLd58O8hbQRWZkTDUm4TwZHM+iZc
         vFdMUo9uWDNKnbdiOl5YAXQ+PfbWaOoMkue4O7L/eZqeUbzNef1VGqsSEQ2iWMaaExJ6
         xI1MLabxxqB/vzdMAJCEDBjoXF11H5+GiYJNjP3dOZRcyywzDJh85UgLiaY7YuakLvpn
         g6Fs3UKT28TrUYqFzJw/nvdNML7OMV+RwDf92gLIobp4QV5B5jKU41hvR1QspYkfmPQ+
         fypTxLhNCaYeo2EljzgOYZ3Qk2YKxMDSO1gDsiIygFU5+xhpMsVZ63oTMUxlWvmDxNyV
         tyNA==
X-Forwarded-Encrypted: i=1; AJvYcCUAYvhjheC53MpWzQEg9gvMv/44FWr8XMbL81zltM6IpYvf2ysrh8T5gQhfnkb1yQb3oLOHcFwkRqJ4P1w=@vger.kernel.org, AJvYcCV5vckdct+4Tn6KSBqWsX6eN8TBRmsm3nHr9y3PJrfuv34/xC4tPgw//K/mibcR0oBVrOle@vger.kernel.org
X-Gm-Message-State: AOJu0YxjX/l1hYLxGkvlAFpTwqFyfs0GqHsO2+y5jT94Zn+e8udgjF1T
	VTS08zLUkknh2dnYPOFfBBQZOP8iGbIgOhazrK7fnEE25bOrDHnb8chvUI6+b1we44//ULhNd88
	QTWk1kBoNkTd4omt4kvpKyhwMrv1a8JtE
X-Google-Smtp-Source: AGHT+IGAVOyxTjetW9FhMV3RoouMEVl2XuncRAo2yNkSgmJ1syLRllBJf9Do/h1xvYUddrqJ0b6ROjxYUvbnjH2i7wM=
X-Received: by 2002:a17:90a:db97:b0:2e2:e769:dffe with SMTP id
 98e67ed59e1d1-2e31535385emr276247a91.30.1728669446034; Fri, 11 Oct 2024
 10:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop> <20241011173931.2050422-13-paulmck@kernel.org>
In-Reply-To: <20241011173931.2050422-13-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Oct 2024 10:57:13 -0700
Message-ID: <CAEf4BzYOdvO_PY-QZySa1qtWqZ_+1zySrw+0Qo1cc9HL5=L4aA@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 13/13] srcu: Improve srcu_read_lock_lite()
 kernel-doc comment
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 10:39=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> Where RCU is watching is where it is OK to invoke rcu_read_lock().
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/srcu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 4ba96e2cfa405..bab1dae3f69e6 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -270,7 +270,8 @@ static inline int srcu_read_lock(struct srcu_struct *=
ssp) __acquires(ssp)
>   * synchronize_rcu_expedited(), IPIs and all.
>   *
>   * Note that srcu_read_lock_lite() can be invoked only from those contex=
ts
> - * where RCU is watching.  Otherwise, lockdep will complain.
> + * where RCU is watching, that is, from contexts where it would be legal
> + * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
>   */
>  static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquire=
s(ssp)
>  {
> --
> 2.40.1
>
