Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C61306D26
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818343; cv=none; b=diFV+Lv0IV3qrg7SovJ6tkpI3Q8OufppK+Qj2++nMUXNpBzdNLI/pQUThiz+2Bpz8XqPfEl5nXQDAxg8eMi0B4uVhRahPsXkT5Wll4oIf1ytBOnIL82JWaSfeHVJG4s0lsn7LHD12Qp0TDt+3SA9t/9TAF2d+qEZ5Hhgz+i5PY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818343; c=relaxed/simple;
	bh=nL6ICthj42DJqbCHvO3LpEi9VZrUNi4EZoXpYsh0G8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtui2mY5IVR0CcvNyQgeSgwQuOtqRKtnmxqJ9hfny3XLHzddxD+WwPIqu20QGlvLw3aoJfU6Urnj7X2vSz95D6JOXwszUauyTHt9ZCfae5e56+KnaoOAVBfJ4cTdIwPj9ZyhtWQZrtAfm/ftbWn2DiJHVVeHeNp6FEgBTvF+2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmALX1aD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmALX1aD"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4cb6fea963dso5011cf.0
        for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758818340; x=1759423140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1tpDO1KihUvNWJ7xp6+J59rCTu8XzBpZg/SYZWoRWo=;
        b=TmALX1aDFCpmF8eklX4/po3bYY8bIgGcTN/o6hKhtB74ySTLFqtAy70R73G1aW2goc
         Tt3+PhdjQbTLUPOmUDz7j/LemEduaPd3XIiYXj7bcdo5nH6AFErlAWigj9LjInJqitHq
         j8ix7Jqzs1TxvDApKN1epi/Tq2Pndxor5LRKXL22Ka0J5J0IaBdrGo7SeTEQODHOe6tZ
         sMK9PRAy5Tbc0vJ2stPtRfjTbxW5GbUd0NgGVMmWFZ0qtAvFHCxe9Kh2QtV6WThDL4Yo
         d3Ik8L8Xj/Icb7S0XJRSZZsMbnpAqbCLi0Mqj8S908fOl+o0N3xd8b6ykY/z9UyiGJP2
         2PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818340; x=1759423140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1tpDO1KihUvNWJ7xp6+J59rCTu8XzBpZg/SYZWoRWo=;
        b=GK3r/5vxYYyFHUpgYgEUSgSw0zyNKgiqEXG+DWneRpubc+hLzyKz48RTmJqfBiAzMy
         HIU7SlyxBahj1Kcco45O1ghsO4ER6mQI3oJE5lbm8CDMcRFnaL3HtTCyp5q2fKiXKky1
         igOP7CTPFv5t+8H+o8AbgxPg8TOOk6Uy7nLqU2KBKZ15yqgja2lEGloNaW15vqLClYyr
         Xaq2G+P7rIu9lboraYyNK6DNuluV3n5eMpOoIjyMfJ1rI9CnQaRclSsInJcei5Z/4lFV
         NM9SXpjBgYfiSarE4ymQ1pjlUsSi6D1SxG/ayg2KHuQLqSjBKySfqgwJ/vxRQ9w2XLZZ
         swQA==
X-Forwarded-Encrypted: i=1; AJvYcCVjpDMAyigWv6YOJLk1bkMz0OlzbAcbExceIHMkwIFxKreC2M6DP3Ne40BO7rDxnYU3chs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaxL3e3JhLiTTfTq5nuK4hIQg4awUfilZL/dRrBrQg9ogzs7Z
	RVJyixwfu26yqeQtE9ujdhOb+iOEjhXMJdkiaiyVU4WhEWp+PMfHg/BVJ87hqz+2haIytYAoBos
	H4qQcRk5vu8GxedSldlEcoXHkoU7SocFwtPUPAQlQ
X-Gm-Gg: ASbGncsewZjLBoVEHwlQ/RVJczQYlBgv+lA3k96/4X3BBOxcpmx/EqC4sirGPjn9XYn
	7BtZS/Ht7xK+rjMXgj2WVOf2EQ0EnkD6BeJIf43FcB5nS52Mnpg3OynCjqjaCVGKUpt4VWn7JPX
	hXV7W55vtC5oZBSMgnQO8FE8rjknCwk3JmyJZsJsupJI1Vqa9SWh3ITGKokx0L20XFF8EIrOXuA
	bnzA6eGFywE9l8PM1LdH7SCqtxs3mwj+ug4LJaXM47+
X-Google-Smtp-Source: AGHT+IHN7bIpZke19K7BOxCOIWISYi7OX+eXxA5ZK0cmFRBomq6+GbhbpYzJ7A5wdxY+p0kNQDC8WuWf9zaB9hJF3X0=
X-Received: by 2002:a05:622a:453:b0:4b7:9e3a:3804 with SMTP id
 d75a77b69052e-4da2ffaac77mr7812101cf.16.1758818340040; Thu, 25 Sep 2025
 09:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-12-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-12-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Sep 2025 09:38:47 -0700
X-Gm-Features: AS18NWBHP_MMQH7-p6dMrlfyKmSei4xK0QXxGzDSsvJq1qMX-xqE7wUlwvZ9tvY
Message-ID: <CAJuCfpEBOAGN+hLssuAma473B5-m-cA4CN3xEyjoM8WXcQv-6Q@mail.gmail.com>
Subject: Re: [PATCH v8 12/23] tools/testing/vma: Implement vm_refcnt reset
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>
> Add the reset of the ref count in vma_lock_init().  This is needed if
> the vma memory is not zeroed on allocation.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>



> ---
>  tools/testing/vma/vma_internal.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index f8cf5b184d5b51dd627ff440943a7af3c549f482..6b6e2b05918c9f95b537f26e2=
0a943b34082825a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1373,6 +1373,8 @@ static inline void ksm_exit(struct mm_struct *mm)
>
>  static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_=
refcnt)
>  {
> +       if (reset_refcnt)
> +               refcount_set(&vma->vm_refcnt, 0);
>  }
>
>  static inline void vma_numab_state_init(struct vm_area_struct *vma)
>
> --
> 2.51.0
>
