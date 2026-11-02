Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793608398;
	b=TSBelc8IodedS6jj1z1pfHEZPElS1IAJQQrh2WX7EgMwpEq72OUwXHTOdRDovcffeTrn
	 9I4eV1Q3pH+Dcpq2UkulKmMOGwu6K8BJt2uB/DpsUgGL7BH/rzmsotcXtaVzhVE7z+MFk
	 /Eo7ugHviyBXROYgYhgzckmJBxbAuDqmneC8sjyKrXEQsX93+syThUbgLfUXuXwYr/e1F
	 MZzCIhqCJWPwMWOxeBbmO2car3izcSssVR9G/vVjcs2z7iCXidzfJC1ZW9J0ihfcg3jKE
	 EN8Wfi2InwemFURAN0X2armrmwxPp6UqJBKKGzUENiZ1NTmfAe29hKt83OHEYl2fkeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j53l0fksxsxqGVEYV0vEjuguCQNdT4wT6diFHQR+URA=;
	b=vCYvB3+u0zBBuCqu89Aw4f1Alc7VkIorto3YRz+XbIfubwXiK9iuMmIwQCZEEim8SVaQ
	 +98dnsmfAxELx3BHZPo+avQo93VaNoBNxteQtHwQJOsh2prUpHQ815QMv5nM0+C2/mDRC
	 TfuHxkjtbfplbxG4wbYoxKaR+ikPTuix6n+aSgIc8oD1b05QlA+9qtSV2Xz98z8j8RP2r
	 dYbPICDautHnYJqXVhq7a0Qz8Rn+Z/5q6LvpUPRTWvpEJhM0ZswX/lCvkkhDBQ3930MUs
	 bLrx0gIwAS6PwE8bd2MEbCdQVBzIcFdAvdulWXbr2ExxRz1iq8GXTASAOb4y+g10pwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=fSzrvNNN;
	arc=fail smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83941606A324
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 08:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83941606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=fSzrvNNN
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c315869241fso374630166b.0
        for <rcu@vger.kernel.org>; Mon, 02 Nov 2026 00:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793608391; cv=none;
        d=google.com; s=arc-20260327;
        b=i4m7BnC4nPYGomyGxIa1tdEcmpzH7ntjCNRAqTY+GlI6qzzjtFjXhl2v78cKgXxGax
         5sV2LIMapcni6MjJ4cA56W8uymNsoaWlVVDNVKHDAQNSQxBNRgUmFjF+LO97BcsJ/BiX
         ySCQOXcHc+7Zi68nTLVg5fZZ2jsQMh+muwvvwmpY6d25i+V0Vq07qUlFOWAkAUc27cr2
         5WrRZkRranG2kuA1vhtZt3ckp8OQv+wLGoZ3Xxg9XCsRjBZCTV9RE8fbLE8Zw6wP1Zqt
         6n2FnDEA+SGjk3sTsSLksLSmrZXwFiOG1fEO1CIBE/NgNj1qL0gl6NGlzQH0zfDiXx0n
         Q+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j53l0fksxsxqGVEYV0vEjuguCQNdT4wT6diFHQR+URA=;
        fh=Q1BDw/0PJABLaHjvQuKR24Xyx8WwuASRqSYd4ke9mXQ=;
        b=P5oDJCOm9e45oU7EuNo8zejHcs13iTWVkGSBpqm8KZsh+GOrgOUNOrvTAJg6ethtWp
         yyHUdDW/aM372gRVX4P6AY44V0KkMCgAeSOiRH3Bp9sE3LkON8cNbKsmJr0qMokFQLpP
         IlfMVpied7IWOjrUNBAzl5F0pcOTEAoHiNBzxYD1I6md/K8yIDJFdVWHDEFDG6f12oO8
         o0xpo7THElTUpV7K7FCZ110LlWGY32Azb0IHhD5JLafLYERAlb1hIaFlJ8g6O/eHIvQk
         8dvQ6V9BjQKDhW5E5DgZsT/bLF9hi20Dti/8BBEzo4p1zeNtcKMJIulmshci6Z+t2rX5
         KJGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793608391; x=1794213191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j53l0fksxsxqGVEYV0vEjuguCQNdT4wT6diFHQR+URA=;
        b=fSzrvNNNe6qGjbB/Oh6/Pf453D9h6ZLRf/22TDRlhmWWblEtYSofQJ9UEV6XS1YRZp
         lfMPwEPRZbB3TiK3uCsz7PEcq75HVKepsbyvtdifteH5kA29ZwMFUuM6p2rvgdZhD8no
         Nh0qSfX2C6dT+KGld4QUc+MdVncLKBXnRDcK01UFqvFjk6qfk12GAI2r+4c1B/iyn9BI
         VX8+WPDh1fyNWUKN4AzhAsh81ULz0xKq8cymxV0QKdiQ9IJb6jvZCw08WktpZ6jMaWrd
         QFTLj+o3V2+BWhlPxJ5+ov+BM6K49+ZJ8dP6efkyl2gS/z4tdmch7qoEOHZPh1l8mmHM
         h7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793608391; x=1794213191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j53l0fksxsxqGVEYV0vEjuguCQNdT4wT6diFHQR+URA=;
        b=Ty+o7ihwgYUyhTcSmcRirRQykrYp+S2eKrWJYO/gpH9BiqwjlHkv0OiJMA3kYr2zaa
         LmE5oB3iS6puFIAvaHQIkYnwDjnsqm9D03lsIvGpyuqpN8j2fGt7u007IvCmGCxMJBSL
         MshGdqgypAtUso07z2bDzz4NWzrpH4QvCcvq+JJWZPzU9B4ST4NngCwhKRuycpoNVgBW
         VudIEOkxzJmV76JUave1z4l5CWomONZYufqvvP8CICV91xr4fTnJ+DppTG8VsvndGjiz
         iyKqrCgcO58mt1PbtimFbD1kav6YSTJJhsoHczAg9u9Gc4d1266oT4+nZfZAvHE3eg8T
         GPTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwOrhLYt75wrRC51qQ3l2ZoaB7adN0AxoHKcGrb/yhh4u+HUThRGotDtKDZIPePVJVO9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxT1IMDIGs91vFPEjUuJYD0Qdf0LQBQVO1+GUy2FxdJzEXri80
	JYsK8/daNEud71k8+cfZwADQL7Scl5RMUjOra3qDKXlk81BtAiij+7urmWyMK57HZ+bkqfWO+WB
	+0ANmYqIhI+V60GzjeGy+THbz5YxAK1WyHRF+YFkIWw==
X-Gm-Gg: AYBFou0Urs7gY3XLc3/mDztALgIINlXXAf8O4ER3eGPdv2OSTaHPrcOBtM2Cork3//H
	f1kp1V0M3VwCLB8HFcn4gLN92JeP6JKXD3c8fto04fF5V4xQUVAV1II1OI3W2VL+TyVGZYi14fV
	XiI/wrVsbROWdPC75YUg3quPSMxDaz8DpbslK8lwpQS1BGDfuTA8bQen6mcp8A9H7D0kxavmMzi
	Sm6s5zJZOHxuE5wHqRnLbPFQv/EpBhRkWg1mNxHH5XwZrLSUubKEhqkwvjVFncnDUzx6GpO/Ymk
	jJ58xkfVzrQ6Op5pfKWkI352WEHtxV19cJx/w/ZVyOoGeZRguX7En309K2FWBPyMaX/MpGgqrZY
	dF32IsEgbAkQUxJHLnFwiVXu/pIWycY2ZuXGzd6rGpaEZopCC1Sr6ZSCkSNaQElvx/Q==
X-Received: by 2002:a17:907:d64a:b0:c3e:f39b:2298 with SMTP id
 a640c23a62f3a-c4ca7a0dca5mr747330466b.16.1793608390908; Mon, 02 Nov 2026
 00:33:10 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-6-max.kellermann@ionos.com> <CAGsJ_4wbQtQ8zfokd44_QM39J_02xDVJoeTK20+jo03_NxAx8Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4wbQtQ8zfokd44_QM39J_02xDVJoeTK20+jo03_NxAx8Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 09:32:58 +0100
X-Gm-Features: AclHuK-7lS1S6JyZadszv7IFLH9vh-tuiPb0pQtxfKPOHSoMU2Adf-ZEzxFVxhQ
Message-ID: <CAKPOu+-NG4sOXVb6xTzVtJJLK4LMag+5GWwY6=7mgSKnp4ZNqQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/mglru: reschedule between memcg reclaim attempts
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:15=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
> I'd appreciate it if you could provide more details in the
> changelog. Without this patch, are we seeing an RCU stall,
> a soft lockup, or something else, right?

As I said in reply to Andrew already, I havn't proved that [5/5] alone
reliably makes the stalls/lockups go away. I guess they are gone
already by fixing the underlying linked-list performance problem. I
thought [5/5] was useful as an additional scheduling point (similar
calls exist already in mm/), but I'm no MM expert, so view this last
patch as a rather uneducated suggestion by a MM newbie.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
