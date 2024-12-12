Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798292101A0;
	Thu, 12 Dec 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026681; cv=none; b=cUwI0a80oorZ26IYTDYWn85Rptnp6ObeuIOtmskghoTH0MZWTp+36tA7Tr2yseWNpj1H1xKZxgVR2eM5R3ZmARRmE4TN/sjneDaB6nsXf1V4bvpouQYY/FmL3+v/izTJWxuyDzdYtitWk+/n6hQHWpovq6mAfmkePVZf3ytrI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026681; c=relaxed/simple;
	bh=GTuXCzykbb8sETyVsKUbKBgz7nizYTQBynmd+d8BZgw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBj9hGZcRAAi6mXf5H7wgYkshWfXsQuWBkjjVGoBijpPrnT7CRum1AoktRaDRbkWVJOLY2C/75TXo7k/5HBqGczoz5WyJnIMHs3dNJVlJrrgtg41BJERHkt7OzdmER60d0AYV/RQkqkTXUYQVp/L2lQNxFkVb25NUnvb+fGZbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmGIOHoP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmGIOHoP"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so6592911fa.1;
        Thu, 12 Dec 2024 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026678; x=1734631478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp6TaF3jjaaKLYE76g5laJgR/wPOP9s3SiCC/jHJpgo=;
        b=RmGIOHoPrH+mqCNdzzwUHk/I8HmxiAklCWazv1LgZ2NMCgyjclo6njCIfrd9AcvJoj
         474R9KbuZKBrPEq42x0JnIp3d/a1EALPpxf9IsupwBWk6RLpS4FyutkMzfGS3GRseH2d
         eeZULtJyAmQqJHBNzb/inOEIQ9vAYd2s85iKWzIgpAFQ63f1cP20rsJUZGaOyjRG0pKW
         sWHUuMBqWMQUf1kwGx7XZwXrjh0+NA+uJp2pZ8cW3F7nixl9JygPJbkjLCmFSYenPOiF
         ELUDZIcGvhLBFLtW8VFl3yMjC3P4EpRjfI5PZyBvoLzsZ75HcoyBdyGTEjgTRo9MnEyT
         lbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026678; x=1734631478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp6TaF3jjaaKLYE76g5laJgR/wPOP9s3SiCC/jHJpgo=;
        b=vP9MfQ6b9rDFbcUz9N4aRjj2iVNmJqGFvyL+lNdoOXXpegkmjJ/iLhTR3fWTj4oYer
         37Z/pUqKmYwmjZ1fxyZ6nDXl8PerMENnJ4AkJ0DhzVxUZsU7mpAVrVREYapLCs8WAWHz
         q0BXOkIpjEd7fpfOP/pqWOWaemD2LyhbjUIYXbkx9foQvlS+aNL0Dy2u+bl/W/xXAiT4
         ArO9gTuYFxfFQ1+Txj3Csfn9egtZbsLRc0g6XsXtMf7OyPSoFZsUJL46Qp+GWlmx74sL
         0/d3icxAegywAMi0grycxQKFCawKGB9Z4CsqRQYhlIFEzjrucViRvioJajVF6ZcUfNB6
         dSXA==
X-Forwarded-Encrypted: i=1; AJvYcCUne1BEEDyQLmMoRwgG20tCvCBIAY3Yg5i6sfxssZEWZluvORnodj7OxeWqxd+LQkJltfF8DtWI5D1Hhjc=@vger.kernel.org, AJvYcCX7z967CI2hmyRWgTxTVQmucFp5FhCcvye6Il3wGDZPs9sTz3TnLcYl5PYIoaHNvkeuWs//@vger.kernel.org
X-Gm-Message-State: AOJu0YyQA+jXPgzFl8B/o9l/pRwtwt/ZEHUKmsty/ykRkdkv58EtWWdK
	qKXhDM16zh+ogpP2J6MDjpGFDi9SuiHJOi1JIk4JU0rl3vast3DK
X-Gm-Gg: ASbGnctJhz1xdQkcJ0ia/L+6ndI4ycq4z8GEwDuMjHpN6L9s6CGdQDf/SLZeC7V7fG4
	J24jSfkvsz1XY8khYD/9viuYoqF5alN81hdZN3baVrLN/EP4JeJuAevI2ntRkdNTuL0ptZ5MTOj
	vRKq8n71QB3a8pZeVrcihJasS/i++8EefCqnblY1po8O23CgzNvnFFx+dQtFFQZqdV4fqucCkZp
	fwXk41sNgiVzI2DvolSppz0z9DDx2A7alFUe798UAInAppFT2k5C7abOrp0VV+i1O3+ErI5pxvE
	tWrEwp5Qizo=
X-Google-Smtp-Source: AGHT+IGTq1Ka830880GIKR/9qF6lBhoVptaMDHpCbWGtqaCSDnf0s6HcZZnUQDniBpJW03L5tzu0Zw==
X-Received: by 2002:a05:651c:a0b:b0:300:43cd:3b11 with SMTP id 38308e7fff4ca-30251e66657mr6241691fa.26.1734026677444;
        Thu, 12 Dec 2024 10:04:37 -0800 (PST)
Received: from pc636 (host-90-233-194-189.mobileonline.telia.com. [90.233.194.189])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30035db98d9sm19102531fa.37.2024.12.12.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:04:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Dec 2024 19:04:34 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [RFC v1 0/5] Move kvfree_rcu() into SLAB
Message-ID: <Z1slsjF6d4mVjc_6@pc636>
References: <20241210164035.3391747-1-urezki@gmail.com>
 <e683b73f-4bf3-47be-b08a-4fd2fe6adff5@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e683b73f-4bf3-47be-b08a-4fd2fe6adff5@suse.cz>

On Thu, Dec 12, 2024 at 11:30:36AM +0100, Vlastimil Babka wrote:
> On 12/10/24 17:40, Uladzislau Rezki (Sony) wrote:
> > Hello!
> 
> Hi and thanks!
> 
> > This series is based on v6.12 kernel.
> 
> Could it be rebased to v6.13-rc1, which is a basis for most -next branches?
> Right now patch 5 doesn't apply on v6.13-rc1.
> 
> Please also Cc all slab maintainers/reviewers.
> 
> > It is an attempt to move the kvfree_rcu()
> > into MM from the kernel/rcu/ place. I split the series into a few patches so it
> > is easier to follow a migration process.
> 
> I think this is not the best approach. The individual diffs are not easy to
> follow because they copy code or delete code separately, and not move it in
> a single commit. I get a much better overview when I diff the whole series
> against baseline, then git highlights pure moves and local changes nicely.
> 
> Having moves recorded properly would also make it possible for "git blame
> -C" to show changes that were made in the old file before the move, but with
> copy and deletion in separate commits it doesn't work.
> (but note it seems it doesn't work so great even if I squash everything to
> one patch - were the functions reodered?)
> 
> And with this approach you also need the temporary changes.
> 
> What I think could work better is to do:
> - preparatory changes in the existing location
>   - splitting out kvfree_rcu_init() and calling separately in start_kernel()
>   - renaming shrinkers
>   - adjusting the names passed to trace_rcu_...()
>   - maybe even adding the CONFIG_TINY_RCU guards even if redundant
> - one big move of code between files, hopefully needing no or minimal
> adjustments after the preparatory steps
> 
> Makes sense?
> 
See v2. We can go that way, so it makes sense to me.

Thank you.

--
Uladzislau Rezki
