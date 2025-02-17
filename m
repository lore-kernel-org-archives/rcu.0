Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645313AA5D;
	Mon, 17 Feb 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831465; cv=none; b=SvBb5Fw1xvvrPIOfwlJIkNchX9PDHnWC0USil3Mw0Ky2YXrCuxT8rt0gQ2VGSKnOlgT4SP8viI/h5flGx8iDukTwPldYGebekwSfQ8FUT8JcOzajCUSfaz/kF6mq7Jdj30fwvzMjCDShZuUO6BRmUWTyMaBp552MZeZg8135/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831465; c=relaxed/simple;
	bh=T5hNLrTQwsGQCQmxBz9cSV0Q8N7zZZiA9sDtfkFRxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhBJaTgERX2C0zsACEnwuwdcpzTbzEOcROJ4jNLook33gLo//bWyram+vScUaP3H5t4qkibbWFChM54OnWtZHeAmqHKl28uauA2pjK+F/mPQdAOLAIqZAIvaObdaUpR2YGxGKVM0iWYZlQAsYcXxuGnyTxi2R4lEwD7rwbQajrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpNKIgDj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpNKIgDj"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8f6so42495971cf.3;
        Mon, 17 Feb 2025 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739831462; x=1740436262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bQUHuPvi38gxl1FGKInFTEyVdgrxrmT7Ir1d6w6GbJg=;
        b=SpNKIgDjMxpp+n2fDt37pz0khAOV+qZ4b0q1mtBOYCdvVQQTBQkPQTAbASw2EOmgOu
         2A2kTUKVyEhipCDx7JdjPIOjQVkxkCn4LtFU0pTYVq/O7pwSpO9UV9Ja6gpELtUE7zvz
         ycfcHD1FjtZTxdBJHqr9UpU4QacRVwNDBa+EJmjR2ZfplOMght5AFmTbwxwD9DFyxc11
         y8QaGBWzdDp8PgT/FNNJi8BPxv8N2LMFn2ePaqiCXDRq/KFn43jxgbzOs2RHfZ8CZx8u
         JH0EG/jzkksLEwOwDYVP0XJ9ZPdbD6SkI+FeyjzCqPOJjtlmTYzY6RRTJN1NhKujHWag
         ptAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739831462; x=1740436262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQUHuPvi38gxl1FGKInFTEyVdgrxrmT7Ir1d6w6GbJg=;
        b=DLYKBG74wIipR9O1w8HXntF4RNq2Bf7kIrbZNVel3LweMu3a7eVu+QBSFZTJ0vX7b5
         8KInnhKSKSWixc2cyHFf68oZy+c41K4n/oxrtljTIJ2cSv+H0S0VviHqFmHJhqvrdJRk
         MtcKEX7PM4naNLvvU1f2NZ4H5t7G2krp9pVcjEgPtInFnw4EjCijQueK9Q98OE+FF7QS
         XkkRtRp6le02F4dK7aPxnMMBYKWTZ55UhtVcyvyMeoxSq+vjgnleqTcFup4q35+G3DW6
         NkgAwYFh72CRfersXMqaPyunFHlMX5romtdhdQm8lXC+feMFQIWNTo8Ef1YxUaZfGxkQ
         WWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoLj8jt/0Y44wy76k67TPC/QQMrc7cbcUUbfWVuR7Lz3P9erfMtehyM2F7NQ4PiRDKhPwLNC+C/t4=@vger.kernel.org, AJvYcCX73FcS53KYwVFBlVTRBzAaGBuWiv1jmCykOX4dmAPPh2u31M0dkyQAtH5DAfh8bWC6lgfI@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8Fxon/kZeW1MEa1zHuaXu692UbjdKuVjPdswOqx3QJqDRqbp
	ERxtXLDNvnE695b/GVqhltJ0fljtZpSgvwB0eWPBjRZGTt+wEZdk
X-Gm-Gg: ASbGnctWYfsi32nLHXz7WFk0RPwN2oW3b63GMKLmI0QJStQBW5sLdZHvJKFXMAUXmQw
	0SgUtNWkOfHDLScBydliLMrKHGYwWNXkeX0U0esIoUtVwQzGRsE0WiVOj6IyfQV0K20w57lc1L7
	JKefquNiRiDbWbJkYTd5EPjxgQmMseovu3YyXEoK3D5Zjwjf97G6SoS5pBX/UD6hq7rFokO8Sr6
	+JXzwkgl/wCqVdznkuOPjHSsLBjZg2EwtLw+1WuFEBUA1UeOwjtak6dpjRygTBjUYWkSTPabmxT
	vhoQ9Ri5vpDqR6L+E4dbx9AUqyUo3U4/5BdB1u7ygmCzB+dkPQzOw/S8IcskbNisn68W/XJcVJX
	+NLlhlg==
X-Google-Smtp-Source: AGHT+IHwgDE4smyAsUHlebwAi/9xq9lslWDX1k2c0MCa0we1nmJXau5RCmMd3DjtwhceWqWnwIjVJQ==
X-Received: by 2002:a05:622a:1818:b0:471:bbdb:9f43 with SMTP id d75a77b69052e-471dbd6b3b2mr143675441cf.24.1739831462227;
        Mon, 17 Feb 2025 14:31:02 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a30b23sm51384711cf.38.2025.02.17.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:31:01 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68EAB120006B;
	Mon, 17 Feb 2025 17:31:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 17 Feb 2025 17:31:01 -0500
X-ME-Sender: <xms:pbizZx1dW_Fxy_2gC9xobFNNUAHEBS3frVJ1Rj15L34s99e7IGPihg>
    <xme:pbizZ4HPQB7V95_eTOnRy4rvpMvLzbO3ssva2NPDvEOqY-L1R4zc5Kc82rHKi_Sbx
    czPyXqiLo4v85-EoQ>
X-ME-Received: <xmr:pbizZx6YUjwzwxwZ3PvcTyIjwhFPzIwUg53UgfsD-3-xXykMOOY8i89F0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefgleehteekgfduteejjeekhfejfedvieef
    tdfhhefggfehheeileeihfdtteehfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrihgthhgrrhgurdifvghihigrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhhmphhgohhurhhiuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pbizZ-0kYWhP9-gwNckKAf159EWaFnUUMCECFvsbWYMEuGCBBwv87g>
    <xmx:pbizZ0FrSYWT3enyjPxNvnFYJ19Q_SyDjdy1sVF8Zh6xCjZse_NV9A>
    <xmx:pbizZ_-scXUzsFCUa7xE-ptjCSdDSJ3qCDJhnfj8hUqjGMYK3rsNYg>
    <xmx:pbizZxlUhTJnypcsaNkNoWGCkfGVcAANpFZF-jDnz83a9S1I3fiHHQ>
    <xmx:pbizZ4EREIqX9FRAN8jAHFWbM-72tCvbX5SP-dZ7jKv2ws_4XoU-XIW6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 17:31:00 -0500 (EST)
Date: Mon, 17 Feb 2025 14:30:59 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Alan Huang <mmpgouride@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <Z7O4owmajnmtqh2x@Mac.home>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
 <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
 <20250217074100.2wyy6akdr2j464wx@master>
 <C6141FF0-5892-439E-9475-43BEF31DFF8E@gmail.com>
 <20250217091842.emsz6graccyjkzgf@master>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217091842.emsz6graccyjkzgf@master>

On Mon, Feb 17, 2025 at 09:18:42AM +0000, Wei Yang wrote:
> On Mon, Feb 17, 2025 at 04:02:53PM +0800, Alan Huang wrote:
> >On Feb 17, 2025, at 15:41, Wei Yang <richard.weiyang@gmail.com> wrote:
> >> 
> >> On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
> >>> On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>> 
> >>>> Hi Wei,
> >>>> 
> >>>> The change loosk good to me, thanks!
> >>>> 
> >>>> I queued the patch for futher reviews and tests with some changes in the
> >>>> commit log (for title formating and a bit more explanation), please see
> >>>> below.
> >>>> 
> >>>> Regards,
> >>>> Boqun
> >>>> 
> >>>> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
> >>>>> The example code for "Eliminating Stale Data" looks not correct:
> >>>>> 
> >>>>> * rcu_read_unlock() should put after kstrdup()
> >>>>> * spin_unlock() should be called before return
> >>>>> 
> >>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >>>> [...]
> >>>> 
> >>>> 
> >>>> ------------------>8
> >>>> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
> >>>> 
> >>>> The example code for "Eliminating Stale Data" looks not correct:
> >>>> 
> >>>> * rcu_read_unlock() should put after kstrdup(), because otherwise
> >>>> entry may get freed while kstrdup() is being called.
> >>>> 
> >>>> * spin_unlock() should be called before return, otherwise the
> >>>> function would return with the lock of the entry held.
> >>>> 
> >>>> Hence fix these.
> >>>> 
> >>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >>>> Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
> >>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >>>> ---
> >>>> Documentation/RCU/listRCU.rst | 3 ++-
> >>>> 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>> 
> >>>> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> >>>> index ed5c9d8c9afe..8df50fcd69fd 100644
> >>>> --- a/Documentation/RCU/listRCU.rst
> >>>> +++ b/Documentation/RCU/listRCU.rst
> >>>> @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
> >>>> rcu_read_unlock();
> >>>> return AUDIT_BUILD_CONTEXT;
> >>>> }
> >>>> - rcu_read_unlock();
> >>>> if (state == AUDIT_STATE_RECORD)
> >>>> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
> >>>> + spin_unlock(&e->lock);
> >>> 
> >>> According to the above quick quiz, we should return with the lock held.
> >>> 
> >> 
> >> Thanks, I think you have some reason.
> >> 
> >> If my understanding is correct, the example here is to emphasize we could
> >> still access the value out of critical section but with spinlock held.
> >
> >This example is intended to highlight how we can eliminate stale data.
> >
> 
> Yes, you are more accurate.
> 
> >> 
> >> In current example, we don't return e(struct audit_entry) from
> >> audit_filter_task(). So no one suppose to release the spinlock again. This
> >> looks to be a mistake.
> >
> >Then the example code should return e instead. ( *key is also undefined)
> >
> 
> So you prefer a version with e returned?
> 
> Boqun
> 
> What's your preference?
> 

Yeah, I think it make more sense with e returned, and you can add some
comments at the return statement like:

	return e; // as long as the lock of e is held, e is valid.

, but feel free to use whatever you see fit.

Regards,
Boqun

> >If you have some time, I´d recommend [1]
> >
> >[1] Using Read-Copy-Update Techniques for System V IPC in the Linux 2.5
> >Kernel
> >
> 
> Thanks, would take a look.
> 
> >> 
> >> My suggestion is to release the lock after kstrdup() to make the example more
> >> intact. But with a comment to explain the purpose here.
> >> 
> >> Also I found we miss the second parameter key here.
> >> 
> >> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> >> index ed5c9d8c9afe..a3e7f8ff3a81 100644
> >> --- a/Documentation/RCU/listRCU.rst
> >> +++ b/Documentation/RCU/listRCU.rst
> >> @@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
> >> to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
> >> ``audit_entry`` structure, and modify audit_filter_task() as follows::
> >> 
> >> - static enum audit_state audit_filter_task(struct task_struct *tsk)
> >> + static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
> >> {
> >> struct audit_entry *e;
> >> enum audit_state   state;
> >> @@ -349,8 +349,11 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
> >> return AUDIT_BUILD_CONTEXT;
> >> }
> >> rcu_read_unlock();
> >> + /* With spinlock held, it is ok to access 'e' out
> >> +                                 * of critial section */
> >> if (state == AUDIT_STATE_RECORD)
> >> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
> >> + spin_unlock(&e->lock);
> >> return state;
> >> }
> >> }
> >> 
> >> Does it make sense to you?
> >> 
> >> 
> >> -- 
> >> Wei Yang
> >> Help you, Help me
> >
> 
> -- 
> Wei Yang
> Help you, Help me
