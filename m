Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E746A61A
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835851; cv=none; b=kZNdZlnN9XfKsml5kJIdBkTteL49Dfk01IOWz4Aw+riuOtlavcwpBGAsdlREsrLX//UMNyJ+KSrPTQrJFsm5dfsAuukGIgRDGfXcYW1Sd3anvBCeWuTVmP+KyNnYDKl0v5V+VKwlz/AgQO8ZGN+wOa2030rS0TzuxkwZ950RvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835851; c=relaxed/simple;
	bh=FycTryzO6CYp9jbhP7pmnkEllg/ck10vYf+Ck/xZVpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6NBdOMUvuMU9rJS+D5N8ZzU6BM1GHpesycaxlkzrwqLM5PO3niPymsl8r5LqOvcWbdXFKlwAVFkyblCBjRpxMJE+GL9tw9zeA0Z6pSxzxyLQjvZIQdIdLyhWfX/v/eacWnNW5XmxrtY5ZN6hZI9GxqLOkL8iVBo3zpRF20hPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmzJDWcR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmzJDWcR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5335cf904so14547095ad.2
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787835842; x=1788440642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zxyBr6L+CuEvCLLnTBBC05O3r7u5XqflfOC0yEsoRc=;
        b=qmzJDWcRqK5OMP0Gu9Vomknjhf/fiLf1bY3hQc/P6rXwU6cDW8s2Rc7ZUqqR5wo5e9
         T2NfMYDoW8OxI1+VHeX5mngLUsIfClK7fNseEsJi5LJDPvAtPS+lE56ncZIZ+y0mm7rg
         u9GcQcxu5XGqSkVsVxxj09kewkwxoXtX9NjNWW3ejZVnhOZBlnvOieVhK4GK2qg3Xg+n
         KgdCkIWSEVFDsXDLI90Q9dhJIWbU4JTzN/WcPwbiVX9wMmIAhJ8xHB0aapuKHQQwMEn4
         f5ncFfy9oLoL9TaD7886MORdkrG82ke3ADYobIo8aHACTRkwDm9wv1ArtumKrcQuyjmA
         sd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835842; x=1788440642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zxyBr6L+CuEvCLLnTBBC05O3r7u5XqflfOC0yEsoRc=;
        b=CKqx+XrM4pCoFWUod+mpehq4rS2a1UbFRlc5/USXLDLjodp3WuPebMoTdG7+OFpNNo
         vAZudDbE7GYD3N2Y9Mq01iIACVLEYqn8sBwndtbj6NgrR4G/YStvKnYiACB1JXdYgxyP
         /WKI12X7tOy/XD5zK/04JYrYW+4DNUTaSw061iSAbIFIzvLa8WbMrL8z71TsqEJwKT5Q
         pDwTc5fOXhNVrqvy7MBvDIwVS8CK6VpD64D8Qz7kb1CYuuv5qQNQ7u7hWaoK4D8YcVDt
         HypDMRiqyn3NZFA4XDebChJ+l5BHuM6qCUq8SpJyLE5XqEQym7PQUgnRppUgIPqT3l/r
         3Kfw==
X-Forwarded-Encrypted: i=1; AHgh+RrtAp/G+77RnRk5vV5EpPrM0Y2q1xD4xU7zDH8KOHhJY4AR9zO+Jbz08wOOhjXeWEBouXc=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Genkq6ZbdNlBZXF8DFeuPXgwAPNhs+jCHZadmXwLux7b/CS3
	GSaP6duKo2RzPe5l1lcBpn+zSD7dOoKA6wSwh9ebyQDGbsP+rNVZnXVw
X-Gm-Gg: AR+sD10PlUD5pAgsr9C0IghspN3zn5z+EtDRQ/cPMSaVAXpj5t3X26VlQr2L8HdiU92
	z5Yylt8PhQpxbrPI6MYrVDhkq7bCOw3ApOb35Cd1hUVOOGWx/BzRKIH5io39txaiuWi7dbw5NJt
	yE9Qpqtp00zkS21hz+ckoSw694Npio0fjjwaomJkcHCQXw2x0dsD78TDFTXKph1l6aEWcqt0/jW
	gdvDJxr+UKvcwayMQ8V9NO11WP7qqEHKACKT9C9AdqG6q+TqQl/wL2j+9eD7CFLwVCibwIr9Zq3
	GdPEY8G10sQ1TqFY2cEDXKwXCXyUQyFmn4gzsG9mKdW6y1rBqPgOYfAHdN3TfhQF7ZA3INRD2Rf
	sJU6r071FDRNe93pcVgJ9qaZyEmLkqKgqffovBsRhIUNAZpopnnXLjqMt4AxsK6JCojbWzngXEV
	GLWoNtbhlHcSwvze5MkwbY+fP+CIm4o939rLdS7sBIQhlqJ+hVnJ6IaptkS8i4aaJIVZY=
X-Received: by 2002:a17:902:f78e:b0:2c9:deec:f564 with SMTP id d9443c01a7336-2d707c0d370mr230045975ad.13.1787835842448;
        Thu, 27 Aug 2026 06:04:02 -0700 (PDT)
Received: from [192.168.55.196] ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493ce09sm16665875ad.15.2026.08.27.06.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:04:01 -0700 (PDT)
Message-ID: <28ac9afd-92dc-4c92-91f3-94f025977ca7@gmail.com>
Date: Thu, 27 Aug 2026 22:03:58 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
 <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
 <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
 <d036078f31cd8f0fdf0b9185ce8cadef803cc375@linux.dev>
Content-Language: en-US
From: Sunho Park <shpark061104@gmail.com>
In-Reply-To: <d036078f31cd8f0fdf0b9185ce8cadef803cc375@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 21:40, Zqiang wrote:
> Now, I am trying to rephrase your problem in the following way:
> 
> 1- the step1 call_srcu() trigger SRCU grace period has been end and queue sdp->work.
> 2- the step4 queue srcu callback has been intercepted by step5 srcu_barrier()
>     and start a new SRCU grace period.
> 3- this new SRCU grace period end, and invoke rcu_seq_end(&sup->srcu_gp_seq), queue a timer.
> 4- the sdp->work begin run, and call srcu_segcblist_advance() with current sup->srcu_gp_seq.
>     so the step4's srcu callback and step5's barrier calback both to be run.
>     all callback finished, but the len not yet update.
> 5- the srcu_barrier() return, begin call srcu_clean_up(), and then the srcu_clean_up
>     find the a timer is still pending and the cb_len also not be zero, trigger WARN_ON()
> 
> right?
Exactly. The real callbacks are properly invoked as srcu_barrier() 
guarantees. The WARN is triggered only by the two transient states: a 
pending delay_work timer and a stale cblist len. So I think this is a 
false positive warning.

Sorry if my explanations were too wordy.

Thanks
Sunho Park
