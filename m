Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DCF9D9;
	Thu, 23 Jan 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596944; cv=none; b=l5rFSP4hgFpdRVpGDqET2wDRvO//Jq0GN74aQ7XRMIJ+LuPGeSS7dXzj9zT/MpWDuJ6U4BmHAy54ViOXV1WJfftm9PbHXydoAKSSS99RMIjkzzmb3GPOa9dOfJpOLquvg8IgQHBfWnu1EUuqcOU2HQqlw8YUwuKVjjKxqK9thRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596944; c=relaxed/simple;
	bh=9d9ld6yeeUXb9NrVyTJu04pfRZfe9RwDQVLS5mJ0NLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjyQ+bnkfsooWfaLSbOzDxACkSHdhoo6/w4tZR3qTEkPwPc0iYI8qRyQfbhZGRlIkBNYvNwzYdkIm1CxgGfezg6hA9pRkLXb6liCz2mQBJxB9qHytQfHAfKTk3QaDmCl8MLnfojC8fciAZLWDKPGbSTzYb7Krx6r/JSQ4zfNqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrbPmryw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrbPmryw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso84567566b.3;
        Wed, 22 Jan 2025 17:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737596940; x=1738201740; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZjlpEqIiGVC+KGh7hOcitxgnEF4CGV3+u0I0ZhaNhM=;
        b=SrbPmrywk8c1rrg3YkCivCMgq3zNtDNRMwZc+kumHsGoPfDpV3ItAbIgvWmSsMX2tO
         lLXLciGy1b+xjppZEDCl7q+Xs6DC5L5GIlGy0x3Hl0C4YKxc+JwHmzVhs5IRtekt2OEt
         Yl/f+2ykGGJ3atxUXivXqkjxN3PR08a/ExsAY6ka7r9zTyvMfF3Zp6VBy7DppM6J+51e
         sA3/V71CIWNyVwWeSiwKxn7dxVMAgzYb6DPau7OH7Nvm7A5PhTZtGDJtmkoFLHk7f+Gx
         uTGh6PnokzbKll6uNpg+1ODZp2LzEPQHBay5clE699Jc+C3oBvk8rqB5dyCg+GsPnlOf
         Q51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737596940; x=1738201740;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZjlpEqIiGVC+KGh7hOcitxgnEF4CGV3+u0I0ZhaNhM=;
        b=BPzQsarQSynwJhXoewd5+2alFSm0sROejs9EpH83NtLsORLxIW4O+i3Dw2qmmroY21
         bqmTxkqGFHNH0geSk0JZSnRHupxrXw4NLldFS/eMfpJQhrRtgKUpYfUUzUm6y72vQSLp
         y3gYpHNr8q/Fc++oViJT2mCfgOgi9JzlrpE//0OOvW8diLxrKUSp8hqKF4ImqKLJ6tb4
         70/0K9NEe6k+18xCK/1jQ4mcjRvkmYDOozGGyul2S9k+tDbShQPGa+6bSWCfnSo8sGz0
         ns2Cj4v+Jy92eDLSU1LnW0KSYoxl8OCixq+lQPhMYg3AR8lpotYw7v6GEbPDNMHeQhgx
         FyTg==
X-Forwarded-Encrypted: i=1; AJvYcCVD+Cd3i4leieY8Zm57CaKDCsNBOsmOJ+HQsHkgmbkhj7MH8Ski9Ah0r5cH4suoUMgalFsC@vger.kernel.org, AJvYcCWml2IPEXM+GCW3/HHGnfBMfZusHSz84h9Kvlv6WyA3UgRT/WM7AqoDDkabjcgVk7fw0VzDKdT7jiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GfZaO7ZUdFiTY500o2c52JTN3zu/A68VIhoswim/BQzzyFzJ
	508FsZvUtnyktUSjAZBgNuuSvXZzP3cqEr3DraqAgr//zdvvA2JW
X-Gm-Gg: ASbGncv/EGGHE6DrZ48JfJ11nZLF77iUe1T/AF45/JxKW2LXQz9/jGDShOClAGT4R/2
	s0QS8sFuAkRskVHhBa08JNeGPUsADtAEFYlk2D6iwW8Dxia/YoR2ZQPXRwDCt6meUKODK2wsOCm
	W7Sct38iQJ1QIoptLbckHaRwD/3ms/gWIBZOtfA0xtWTzDqoJNq3P8iUcJcMzaDPMI1ijTjAymZ
	xawUrOR8RJmSaw+NLatliPYHt2CNNOn27YwP1ycz66Rtd19OeJG69gTZ2lQ8DWgG6mF3v1TqDH1
	9zu+
X-Google-Smtp-Source: AGHT+IF14IWsMMIZUyPDFosq7HEcfQ9ujGKXpTLpkaQJZ+5sr/y/pGUCzKd/QV+mg2GWBZgLDgQ2Ow==
X-Received: by 2002:a17:906:c143:b0:aa6:7737:199c with SMTP id a640c23a62f3a-ab38b26f3cfmr2120204166b.15.1737596940234;
        Wed, 22 Jan 2025 17:49:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384cea13fsm981030066b.71.2025.01.22.17.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2025 17:48:58 -0800 (PST)
Date: Thu, 23 Jan 2025 01:48:57 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <20250123014857.fgkmlkpao6q4yax2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101082306.10404-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Ping

On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>The example code for "Eliminating Stale Data" looks not correct:
>
>  * rcu_read_unlock() should put after kstrdup()
>  * spin_unlock() should be called before return
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>---
>Hope my understanding is correct.
>---
> Documentation/RCU/listRCU.rst | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
>index ed5c9d8c9afe..8df50fcd69fd 100644
>--- a/Documentation/RCU/listRCU.rst
>+++ b/Documentation/RCU/listRCU.rst
>@@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
> 					rcu_read_unlock();
> 					return AUDIT_BUILD_CONTEXT;
> 				}
>-				rcu_read_unlock();
> 				if (state == AUDIT_STATE_RECORD)
> 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>+				spin_unlock(&e->lock);
>+				rcu_read_unlock();
> 				return state;
> 			}
> 		}
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me
