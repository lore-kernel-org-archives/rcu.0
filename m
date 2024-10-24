Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AA1FAF1E
	for <rcu@vger.kernel.org>; Thu, 24 Oct 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790828; cv=none; b=UEsn6oh9xhE5Ido1ChSMpZVXjr+ZY9fnRAdqns+jY6xTTbauoHz2oiITi14h0rSzrwE59NoTNPKyXXwYvDxlBA6g3Xe2NUTYIlghncUnTNNpXn8KdVJE6HKErxfCvxX9H1qe5846Wkfpug/Rmg6FhBLdmqXqFLSYaG/G9DW8Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790828; c=relaxed/simple;
	bh=h8RFd+d+i1wbRBi6yqvvSPq8tMEmRyVuXH8u+OiSNKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1dmCsJeqTT7rVAIC7VrMTws+UkwmELIzkmJ0c2iRUb4WxkImByHlbiauh0+tQqDf8t2PchJtLmaM6w+DaJGZnFBgygUZNXor55fGcYnbYrhuFr2Qs2Cwys7rOPbHQpm1XwsTVpe10rDu25Tc0+8O+/2gq6YovJAu02mIDH6GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfj75SZ6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfj75SZ6"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e605ffe10cso729675b6e.3
        for <rcu@vger.kernel.org>; Thu, 24 Oct 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729790825; x=1730395625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bnWcdm5+hNqSVcQRV8A0OvOCGjR5wdTjA31GYBYKTQ=;
        b=bfj75SZ6HvWNBXaxXLSF0ZuWZlItSStglmpmogo18PSi5u3T9xJcaf+npjzzLCqon8
         JvIwRx4m4SV0jus5jkRqXvPY5Bk131+EBIaH6fp0nLNJ7da4DX6qcp+fqdPvyrWprKhL
         YYo68XjQBVxeptMRUGjRbHekyXF5s4XO3r/JsnY5fqKmu/QB3of2944A0n7GB51HpcJ8
         8Ju/iGCNt180bkXMRv1LXdQKlx2BVAPsVj9FfCBKX6FV8D4Z5nwbIseJrnz3LZzf1/UX
         m0izVBO/QYuNq2oI7FivW+PPtQKaOZAmDI9toTD8xNoyfSJhZxCRW06uJWvWE2hdiVk0
         nYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790825; x=1730395625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bnWcdm5+hNqSVcQRV8A0OvOCGjR5wdTjA31GYBYKTQ=;
        b=S6vOOkMFKkTIsxwehaLf2drHFkqdQsRshj015v16VtP6hz4lI5dMan5jEntrCsb4Df
         U5VgqThvkP2Mcy66oQFsvKAcvBA6UHQ6YSAvSaC5EsA8aBGS9UwfoAlc8qtC8JBQm4w6
         Z/jis+pcEj0zPbT0E0pFwbyUf0ItDXQDMu3vXRl4dj+v+PJwEllR9fYHGJdmGhT3h66c
         Km2XuJWBTESOMqxeCwVL1JPohWDc4mIeFXDiT2UYanYFXMc/oqKQTly1VJbEqIaL7MIm
         D9iMsiEUVRytbkO6AoZUfFoVAyyk9peiOmhNvd2xsohASlyJNaXlcluAkCJlbgHMsQoY
         4M9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRllYNSEIvRTgHpGK66bPJclMOYr1HO47w8QLnahBjOzcqiUlLAePpMMKhDq9N0HYDilg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZfyjBg/hNSutZnQbCuB+oXBOyPkGIexbS1qgxlB1aMFEHiVc
	0vU712/17YDDLsHbLitX7sZ4ic4ljoVPNAm8wfgDl0iBKWaK9IlfrFZVqX7a8SP6ESjNfPa8BZn
	UbCmhCxqW85CCNmfiKl/N/L4SQb4kBhvu/udTmA==
X-Google-Smtp-Source: AGHT+IHhQgBabBejMOJrKixD9g1JQGyZY7vFWmponZeA+I34SkwPlnziEuk8soIt/tK651/v3WePSqfLEmAYknFqfOA=
X-Received: by 2002:a05:6808:3092:b0:3e3:e0d6:1434 with SMTP id
 5614622812f47-3e624501561mr6952186b6e.1.1729790825369; Thu, 24 Oct 2024
 10:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsaQPsvJdCsezaTu1x3koCzkTBEG8C1NpZotZLXZpZ9Qw@mail.gmail.com>
In-Reply-To: <CA+G9fYsaQPsvJdCsezaTu1x3koCzkTBEG8C1NpZotZLXZpZ9Qw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Oct 2024 22:56:53 +0530
Message-ID: <CA+G9fYu1QsoBLgqn5yQF28n=0gz773-cO2jq9J=qeUNugD+Hcg@mail.gmail.com>
Subject: Re: stable-rc linux-6.6.y: Queues: tinyconfig: undefined reference to `irq_work_queue'
To: linux-stable <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	rcu <rcu@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 20:11, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Most of the tinyconfigs are failing on stable-rc linux-6.6.y.
>
> Build errors:
> --------------
> aarch64-linux-gnu-ld: kernel/task_work.o: in function `task_work_add':
> task_work.c:(.text+0x190): undefined reference to `irq_work_queue'
> task_work.c:(.text+0x190): relocation truncated to fit:
> R_AARCH64_CALL26 against undefined symbol `irq_work_queue'

Anders bisected this regression and found,
# first bad commit:
  [63ad09867ee1affe4b7a5914deeb031d5b4c0be2]
  task_work: Add TWA_NMI_CURRENT as an additional notify mode.
  [ Upstream commit 466e4d801cd438a1ab2c8a2cce1bef6b65c31bbb ]

- Naresh
