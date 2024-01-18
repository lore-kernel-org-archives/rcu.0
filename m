Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F3125B0
	for <rcu@vger.kernel.org>; Thu, 18 Jan 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568563; cv=none; b=EIr9E5tVd3hfqBs5D2Aj+m6ownSkvE9xvOloqVuBcaPIq9oSGGHXTN6Gpa/7iGQFdKCHLEJc86KB1xY1vd7IJyNNTvAhv+4afgUD1F/dSXs6FdT0HpXgJhiwcTlB0bikSrzgQB23PCDHrippinNrwOdKFv05+M4A9EUwmBA1Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568563; c=relaxed/simple;
	bh=Nl/rIH1RimRHGQpazXMbevhw4cRHoT/buJCa7tVHuLg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=S5bgiFvlcXZPS96o2bEFp5aRoz/6mHxz02TEFNZnPLSam9aOfQdLUeMEWYyxoa952Sqw/18bLTyuOGtG/cR/GKoLdk47V4A/y5sp2pfC3jMFtzjIWKpwibfYu9CWFcJ7nKHQUeJ1EIr3jrqvRthlSGUiyF9VLiaaCA972jXwhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hu3yt/cH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu3yt/cH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67fe0264dd2so74115746d6.0
        for <rcu@vger.kernel.org>; Thu, 18 Jan 2024 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705568560; x=1706173360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZx8jkcSyxiY1OJQQRVdDwc9jw/KxeIOYkFsA2FOdyk=;
        b=Hu3yt/cHmxvFfgMaSwzlpvIBAiqAKBOl/2cOviM7s47ZGdsOXEpE42VP87lGsSxJPr
         WZNMvGiKBePcNJhApVkd7luXbCcRUrpfSzRDdB8dCgXmuUVXM2rx2Iy2d41FlbaOYC5X
         hyUGvY9p6a5ieBi0E4kdRdvlhwmeInbYJZMI68Vd4pNY0OxmrjWbP/s8oROGWDDm10eF
         EHpbor0hPKqrwZOEgknvft9rT0QHb/XSFeKJ84HrgxV1b6uYy0ZJMq4atEoz3IsGysCp
         8j1WTyiHyRIrQTh32ZEEp39pE+8Qzx6ntOp8KcFz++GUvoLf6Y7/NluEdo0IOdMvrMxX
         MqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568560; x=1706173360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZx8jkcSyxiY1OJQQRVdDwc9jw/KxeIOYkFsA2FOdyk=;
        b=V014g+IU1q4GcB3Ykgzr7FiP29rn3N9VIIxLDqefRMMdeakZuv+rexbQdPDSI1SmNp
         yU6OAYg0M8BBE0djAF8YKMfpguO7rStE8o8ADAWeVJGZznIBl13iPSeqklx8FBEBABip
         xbRiSdDT0uaWXSgUChd51gjR0s3S9v4FOoYDv9o1sVrFZ+5+p67VFFROxk+ZGbi6DVmd
         X8Y5Q5oqhaRNP8T8pON1tpdCl0b8N2bLrrwjFI6L3lnRtDxiTwdJJ3mqMajc4YPb/YGC
         ykUU9NumoxGkHdFEt6sIvLSEtyYSjgLXaSvS9vICM3VKBFj/ws8yuDTEssille/TkWVG
         zYvQ==
X-Gm-Message-State: AOJu0YzrFmMOKywJu5ixRRSS+bSsAXW67qRWJltd2/EkvTcaYTdSxdO1
	d8W182IsbBuFWQ7i96yQDOojhVpRS9tJddC3QsKaqIA1nFdD6q6+KTT6D/Hxd/pChTUfTmTHrlz
	JdCrQO9Hcd9vjltsHkyWA2+toyc13tcxpbLr/
X-Google-Smtp-Source: AGHT+IGzaN1qKPT5YRlCBwEsg7XH4i+PuJyz8L04g9JEpbgJdI9ce77LIl/RZ+4p52Xb99R6mwrrK/ZPB53xiCbcATQ=
X-Received: by 2002:ad4:4ee1:0:b0:681:86fe:6fc with SMTP id
 dv1-20020ad44ee1000000b0068186fe06fcmr477337qvb.116.1705568560115; Thu, 18
 Jan 2024 01:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20240115184430.2710652-1-glider@google.com> <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
 <Zagn_T44RU94dZa7@elver.google.com>
In-Reply-To: <Zagn_T44RU94dZa7@elver.google.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Jan 2024 10:01:58 +0100
Message-ID: <CAG_fn=XcMBWLCZKNY+hiP9HxT9vr0bXDEaHmOcr9-jVro5yAxw@mail.gmail.com>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To: Marco Elver <elver@google.com>
Cc: quic_charante@quicinc.com, akpm@linux-foundation.org, 
	aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com, david@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@techsingularity.net, 
	osalvador@suse.de, vbabka@suse.cz, "Paul E. McKenney" <paulmck@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Miehlbradt <nicholas@linux.ibm.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hrm, rcu_read_unlock_sched_notrace() can still call
> __preempt_schedule_notrace(), which is again instrumented by KMSAN.
>
> This patch gets me a working kernel:
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4ed33b127821..2d62df462d88 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2000,6 +2000,7 @@ static inline int pfn_valid(unsigned long pfn)
>  {
>         struct mem_section *ms;
>         int ret;
> +       unsigned long flags;
>
>         /*
>          * Ensure the upper PAGE_SHIFT bits are clear in the
> @@ -2013,9 +2014,9 @@ static inline int pfn_valid(unsigned long pfn)
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
>         ms = __pfn_to_section(pfn);
> -       rcu_read_lock();
> +       local_irq_save(flags);
>         if (!valid_section(ms)) {
> -               rcu_read_unlock();
> +               local_irq_restore(flags);
>                 return 0;
>         }
>         /*
> @@ -2023,7 +2024,7 @@ static inline int pfn_valid(unsigned long pfn)
>          * the entire section-sized span.
>          */
>         ret = early_section(ms) || pfn_section_valid(ms, pfn);
> -       rcu_read_unlock();
> +       local_irq_restore(flags);
>
>         return ret;
>  }
>
> Disabling interrupts is a little heavy handed - it also assumes the
> current RCU implementation. There is
> preempt_enable_no_resched_notrace(), but that might be worse because it
> breaks scheduling guarantees.
>
> That being said, whatever we do here should be wrapped in some
> rcu_read_lock/unlock_<newvariant>() helper.

We could as well redefine rcu_read_lock/unlock in mm/kmsan/shadow.c
(or the x86-specific KMSAN header, depending on whether people are
seeing the problem on s390 and Power) with some header magic.
But that's probably more fragile than adding a helper.

>
> Is there an existing helper we can use? If not, we need a variant that
> can be used from extremely constrained contexts that can't even call
> into the scheduler. And if we want pfn_valid() to switch to it, it also
> should be fast.
