Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342A2E7621;
	Wed, 16 Jul 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643942; cv=none; b=X10w7WL8rnmvJbe06qgj9C0DyzVAiP8gCS3Ji2rfODhwon5kwIBhCaMsO/Ptj6agbDl4At0NbZe9PAG5KiEogPeH8hfOGG8+Y7YlmHZrKJ2BZldlc9Gq2zO92OyyX5JgW22eEUeT4rXfHeTDnTXNsDSdsQ9/wpl7UVyszS65W+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643942; c=relaxed/simple;
	bh=VjZrGkC7ADyps82wJ+kFXJsVELSbQQ4Qa2DtZOZN9fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ya/BWTNEiruq+slmDd4SciY110xYsx3Eyz+ukU7AKNOHHp8YX4tNlGJ2DPJbx91TQEWcvWR2w2Pc7zaYrvkbkrQ1x3JenTjDbF3qcG7pflXZzNnCOfyHz7UcEfPCCOSor7hA8uPmP/UlDhrT+Z91t5jKC7A0psb0ZPz9+B6zUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8VwERaf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8VwERaf"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so1058593766b.2;
        Tue, 15 Jul 2025 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752643939; x=1753248739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp/akMFaM7KE8tpmX3u+HdSoxH065TZxIp2bHG9cbeY=;
        b=K8VwERaf9nHsNft5mhEN6oh7uuYrbzW8QxHpyE+O+LUx9d2WyIMP9aLqh/VMn6UJ2d
         lJ7ISP9S6aOvw/LG5luK9DJeMD3HIIGRv7WKTAA7R5t8tGFLR30zVO1aQj+4OAa/upL2
         rYHllAIFJc/IC3z9AyYl18tzsF0SY0nTiNyPSgoYazI7n199Ofz/yWZvcqA6ir4tFIzz
         42rqq85Ez/P/sCDpkzACHic8NXKieoDXUXXqWlLdKtSfYAA0400TMXyqcZ8xmHbXX237
         guzkb/nM8IDJkdGipJtrCVta9xbgPbJlcQJ2ybEJupG+M6jNGrKh5xHaREwVzzu6Lwqd
         F0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752643939; x=1753248739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp/akMFaM7KE8tpmX3u+HdSoxH065TZxIp2bHG9cbeY=;
        b=C/NMB7N2twODrjU5CcLwF8La1QqGwKxShEYWtN4eQmvtiYDA0BwdXhxGNUTslj30kT
         0JFIldnPeTHaSolL3NTJcwKUkyohcjvhWm13TTvjZvowET8AnCfo9LiIXB7ROxqBeV6x
         8tzOk38mFeQMTw92akqM5YDO2tN5l2bhSIoXWiGIBJ3c8RS4frUKuZ6pg5y5oA0/63Ke
         +5dYJxhl5x6WiaTr/0JOeadSLSQzTu0RLRS/xpB2kjSKjW2pqz9X90o+YsPoO5n/Axua
         IVFo6vYIixT8/s9PP/j/xPJfwqxcHf1sCVwVXM4tQnFPuf1E2dG/A8Ch5kgB895luCYe
         jexg==
X-Forwarded-Encrypted: i=1; AJvYcCV4AHXw+GPsdiBFEulq8/u4AWKXHOAoxhv+O41QiwRiIU7E6+KgaDBQsJqD0YJz73SMWBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vpFJ47wWiMJHH1UH8/11huj4ZVbb9J0bcTWgdHLv/9gLWfOk
	sH9AA/YxtwSPxaoDYedhuBzVtq/3bMcTsAQ+sSsTS0b8XRUU+rpURJSj6KawFhdnusZucoahdgu
	3ZSojb7qZrkXDPBTGw1a1UacQqNlpPwc8lSIK
X-Gm-Gg: ASbGncsqCkPCC3Y951KcnjdYvFy9syEfkbBma7uQwiTlk8qGpkam9rzf7Yx0ViSnJRB
	IWZs4mH81dcg9Mq2c2D3YMHXyrwN2K9w1k+XEady6K0BzjoET1oMH0q/Zwp73Q+pxIQLV6y6O23
	ZV2kcAZOUE/BIcSQhZ1nptx1e8wtJz1Q5QQuaIqY3yuCKl9rXEcHf6T/FheOYQr+1n/lWk3To8e
	vas
X-Google-Smtp-Source: AGHT+IGWzJc/bkqkIzkoQzIlake7ZNKtY+H9lqIhjKYDy3vImUmhxWJB4LjzXDCmQnar9NvkgI/OQYObPV5zuHO3+bs=
X-Received: by 2002:a17:907:7209:b0:ae0:d804:5bca with SMTP id
 a640c23a62f3a-ae9c998539emr195067566b.17.1752643938265; Tue, 15 Jul 2025
 22:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 16 Jul 2025 11:02:06 +0530
X-Gm-Features: Ac12FXxwqhNdkUabOwevbJjOQPNDfrEdVr2XKIJPHsS-BjxPMWcWkYVc7sYn0lE
Message-ID: <CAFwiDX9oGOdvFjdRrrfqrnHeFmfz3GHmA1AgHMZAHGdyn6qPPA@mail.gmail.com>
Subject: Re: [PATCH -next 0/6] Patches for v6.17
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Wed, Jul 16, 2025 at 1:32=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Just a repost of patches with tags, for our consideration into v6.17.
>
> All have tags, and the last commit is a fixup for the deadloop patch whic=
h can
> be squashed into the original patch.
>
> Joel Fernandes (6):
>   smp: Document preemption and stop_machine() mutual exclusion
>   rcu: Refactor expedited handling check in rcu_read_unlock_special()
>   rcu: Document GP init vs hotplug-scan ordering requirements
>   rcu: Document separation of rcu_state and rnp's gp_seq
>   rcu: Document concurrent quiescent state reporting for offline CPUs
>   [please squash] fixup! rcu: Fix rcu_read_unlock() deadloop due to IRQ
>     work
>

I have included patches 2-6 here:
https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.g=
it/log/?h=3Drcu.merge.16.07.2025c
for testing

Fixed few whitespaces errors in the documentation.

I see below warnings while doing `make htmldocs`. Can you suggest a
fix for these?

Documentation/RCU/Design/Data-Structures/Data-Structures.rst:305:
ERROR: Unexpected indentation.
Documentation/RCU/Design/Data-Structures/Data-Structures.rst:307:
WARNING: Block quote ends without a blank line; unexpected unindent.


- Neeraj
