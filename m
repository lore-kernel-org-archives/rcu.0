Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72253A7822
	for <rcu@vger.kernel.org>; Wed, 29 Apr 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449666; cv=none; b=UC4C4pP0WK5lO0Rd5ys6/R0+AEHd2JbLJIgUiQRk7MrM8KwDsJrUytJDYW6fz/yCJkO+kTEWi1lk5GI1HGkmSlkoK2E6KY6HIk0iMG4Hj9rirqFGd3D5ndFqZl4mj2GG8YKAB8HtYLYOqaH5AgRAaXNesI9LJK3bgFuxiuoMuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449666; c=relaxed/simple;
	bh=ryFVdBG1ajgc0fxZzunEYPvb3pz5Q6LyDKZL3IMkZ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEmbjF1Hut5aozG9xBExOReV92hUOS91xIDUqQUwsGJejsYyU9Hc4HUb6VWuhgoxg/gzMTgwD/ZDzSbZ7VhguqPzCKosKQt8HVNwx6anxNLK10CaAiekYzk+FaZJ2XOnbTpRBdqcWZkZj9B5CAK3t8ybi0rNkmjhfrJ+wcmpbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EQ0mHUcM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EQ0mHUcM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf7190580so901825f8f.0
        for <rcu@vger.kernel.org>; Wed, 29 Apr 2026 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777449663; x=1778054463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPx/kD4WGWKxwaJpCnYAciCBrDKMYIK8dIZn6jPFTzk=;
        b=EQ0mHUcMAWKRdCgb4TcX/CqeEKHxNdkLSiYP7CwsFbuQL+LU7ZclPwBWMAbFHS6k/D
         iWxmhbPPDFg4soy/Jt9+4hjrPQpqrbVvfef74S6wKZqcs4RzlBgbc/WUEzAT55Teq4Zy
         tAGKWpZt2+wyKpXvX9dZzcWFu0Cn8NJ8daYPLlNiZ4XdqKImTCW1j5VpucqGHu2cTGmD
         BpAAd8YoK56CxYF5jIo0sRmMEq7bo7Kagc6en5M4nJLq7S+em2Qaycx4u1wrvdVMQwFd
         /CxTIGdgJkU+XfERkzwg1TUUymoFShVx9KoBkzJkWH3a/btwNSjFk3O8/bAl/WZydUtZ
         NJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777449663; x=1778054463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPx/kD4WGWKxwaJpCnYAciCBrDKMYIK8dIZn6jPFTzk=;
        b=kD8Qecw7bRs5ZNLBkJoszntQaHQBVY0Hrz5/NnTab0hPhuzpAC37qTUhztTgI42a95
         J7fXPsGFTnSTDghiY4iIS18fdr683N6M3JgHO9OYv/0RnbSVZgbfR1gKnojh7fEP4ftR
         iCuDkK9ri14cvTPwjFJuyKCThpbchGsVctD4gtGg6GZ5KVzYQ75gFgFZtE99tnFL+urS
         Rs0get2l1K8iamto4OqLjGA3CDrbJcTPTuct/K8mjHIDBxR8TitLuPetvU+YDudLUnol
         PVrz0oL8XE8ICM7qqJyi/f7HzU1MChCTdaJsQvkRT6Nrl8WtE6IE1Bekb+Sx+Q6wD72Z
         1JyA==
X-Forwarded-Encrypted: i=1; AFNElJ9OIEl33qsVd25JV/ZsPl4oDauM3C1gsIUjcmbQBPElGMwCtxaC9HsKcJfD4hzetKAT+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BADWcKXYdadOSg3fBZu2MVBWqKfFzaZ0KrHByQpl+C9YAHp0
	ClfoSwhQO48aKbWluBYQOe9xAX//PAwEyzw2oNLuYrarFSZ6OHtg1SJQ09pteC0NHjA=
X-Gm-Gg: AeBDietI6y+044NEqAvhNkPkaXy7I7N4SvouRjuL4gUpWD98o15XWUPuIDqB8cvl0O3
	0MSqDBA4mf4mQ1of0vadMjG4TToAeRG+u3zVGjEV4QW/4ktIFf36dKYF+vT3uOhToiMWOrXZ6gc
	EX9KleLPXPw2NGtHK1Qpr5uMhIWch+1boak47uF6+zjlMY4SzIK+MaATlTKrKi2txq/gjYGWBEQ
	xxER/70nNEoQHxtLO9GwNi9oVNwcBgzOLMXC1yVK9akSNTPgrJYauP+qcaTFHo0+4SDsg0yJUJo
	O5wSGCAU+VulxtrUOjBKI8o1ABpzEealZMwKdemCF+U9oedsncgT3OUZ/SDTm4sLD+j/0H5Y36+
	gI0A6HLRwic+6pYCh88JfoNMWKnGa26f3IumYy4cxT1iOVYmYwBoHS6Bujn7r6H/FrEa2NLBeuD
	MxMiNRI9Mjd1o03W9JvizosbHBHjO6HTOnZEz+FjyxxMVQVNb2dXVyqnrwEoJDyrruQlMA
X-Received: by 2002:adf:e00e:0:20b0:445:c2b4:a284 with SMTP id ffacd0b85a97d-44643e18116mr3536239f8f.8.1777449663151;
        Wed, 29 Apr 2026 01:01:03 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca6451sm3922019f8f.36.2026.04.29.01.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 01:01:02 -0700 (PDT)
Message-ID: <1a9ae46f-b43a-40fb-8bd8-750c6e17dd01@suse.com>
Date: Wed, 29 Apr 2026 10:01:01 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] Documentation: RCU: adopt new coding style of
 type-aware kmalloc-family
Content-Language: en-US
To: Manuel Ebner <manuelebner@mailbox.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 rcu@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, linux-mm@kvack.org,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20260429070759.309110-3-manuelebner@mailbox.org>
 <20260429072320.310817-2-manuelebner@mailbox.org>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <20260429072320.310817-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/26 09:23, Manuel Ebner wrote:
> Update Documentation/RCU/* to reflect new type-aware kmalloc-family
> as suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
> and family")
> 
> ptr = kmalloc(sizeof(*ptr), gfp);
>  -> ptr = kmalloc_obj(*ptr);
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

