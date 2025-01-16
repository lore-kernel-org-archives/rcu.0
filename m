Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871731A0711
	for <rcu@vger.kernel.org>; Thu, 16 Jan 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063509; cv=none; b=XIy4lhCbUza/r82zL6tX70gxVOSq8lIb2KiKOvrtsdK2ZupA5eU1L7NT94H6SYbHHWZB0HKsR44tG7BJ8pGT7LCVsB9lYWQPtaiDCU2tF4JBdVZi1Vl8ym2gcFwXJ75qFYU6vlKN/NNHSOQbNY797h8+h9Si51njsVI1EVF0fHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063509; c=relaxed/simple;
	bh=6XHIVPjGu2PXGnHiltbPyonYLGPrw0tB4DmQEAIZsE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS0ZsUSd8GWuhTsFsrQlnv6iWFFAFji2J6D+hKfBhEAbpZjbtvkQCCmC342o2wKuETMstGgvuznrlG37S8agxhlGf5s0FOjq+UPyBrOaaECWNFyFvOfljPMhQUS6VPiAkmJ+VI071y/uEEhLz/F6UIJZZkSv+DCz3R69BvKviQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uDGupkUp; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uDGupkUp"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so9100705ab.1
        for <rcu@vger.kernel.org>; Thu, 16 Jan 2025 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737063505; x=1737668305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgZXwhIbMXY/TwJHgja6LHn8HVFhHyWdPne03eqR/vY=;
        b=uDGupkUpTshAzDZupw3JcC81tjs3PnLTanw693AfMLrWrGi35bvDpiQs1xGxEVnLiK
         5LruXOagvYztyyYtvrdRM8VYt4i4S7g5s23o6mUjZGbkLg5fflvgF+1ptIsN4J442u3F
         u3KdfvAYasrq0/kOQWHh47rZOW6q+c46pK3+JB6H71Nf4d7vsKt0DEWmgIFaey6n/0l5
         LiFokPXSjMCyHfawwYRsQNonp4o7ADFo2Qu4YpUCoBd/5a1HwrlOwH8IZosxkxdN9VWO
         bFKm5yLE/yjl0t7O0egOe3zm7+wJ64OQwwAWum0AomYaehhUJLYfIqqWU94F2nOaquch
         X8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737063505; x=1737668305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgZXwhIbMXY/TwJHgja6LHn8HVFhHyWdPne03eqR/vY=;
        b=qYCZDIGyWxtr7IbeNdd/XjPolcy8id2A6A8UZLyepHZi1jGpdEopQvKN/XNvM2hDHa
         mTrGalyjFlmt4bsyzjyrc2E9K5AarnWtRSMiqVawoTo3Zvo6LIhydHeJFZ+ZUiuapxhm
         1aPiCgUi9nj0gRdJvAOlMgumRGZRhqPMIvCmcS6JmmJXn93G7HFprE4l3433W6/TQMg9
         WBjWgKRPcVzVmSgS2jJFqtmDzrDy+qB5Trgle6mBTOO8QXW1StEwryKZS38LWv/nk5xG
         DUWBgWy8CLoU4yPjES+mMF32Rayd6AmEEDDNM80k7P7q+ozgo66P164ruRbNQVXRi+z5
         QGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1Db0MGoXT8DVg1YPpthWqiKdqQNJhtjO7ql/KkwcOUzes+Lmdf4ayp4Mn0xDiOHyPtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7sNvTBC+9iX0QmON84+hU+WywJ9EZvLgavzWTQiSv8cJfuBl
	coY9dQymhSXS+fs4mHfDWjR4jRPcCeJmd7cazrH8aBublo6hMZbDRQjKsfapN3CreEL6V6I+USG
	T
X-Gm-Gg: ASbGnct8ZyUkFUzfBXjTOUewWZJSFjs76KZAJTe+zitZiXXR62WK58g39hvqS3DAeYK
	TuXs2sUvXaeVL+Oesslja16Pdz+cZuVb5oH5uWsXG3WDlPmaHFQrLD5opnV0vrpvqV/LgGaRuqi
	vduIjmu1aJvX0NyLPbTSdxUgj1bgi9Ty5AGUckYm9oFlXF8uhyNLg5hHfDlmZYyuo6DkHdfaLnm
	ls3aVGMQVQclfQ0tHwMPWmQOC7uFEbALbvkq8eJGQF8xrG3XmPQ
X-Google-Smtp-Source: AGHT+IHElLYUr786BLlL9LbMjWXZHuXF434Z7WeJnvG3d2kRye70/yQwvxJpQq7HSYTp92RqeWf/Pw==
X-Received: by 2002:a92:dacc:0:b0:3ce:6a08:2584 with SMTP id e9e14a558f8ab-3ce84a1a9efmr71928945ab.7.1737063505457;
        Thu, 16 Jan 2025 13:38:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cf71b6846bsm2084615ab.65.2025.01.16.13.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 13:38:24 -0800 (PST)
Message-ID: <e6283b39-5101-47bf-a4b5-bde247ce3bdb@kernel.dk>
Date: Thu, 16 Jan 2025 14:38:23 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 3/7] rcu: Document self-propagating callbacks
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
 <20250116200239.3782374-3-paulmck@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250116200239.3782374-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 1:02 PM, Paul E. McKenney wrote:
> This commit documents the fact that a given RCU callback function can
> repost itself.

Thanks for adding this!

-- 
Jens Axboe

