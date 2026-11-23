Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440733;
	b=GRPV8Qjyav+nNvHeWsQzbhRI/V2XK0ymPZtq+XJj+T4a4XXz/5xle5tCvsWbHBGeZc91
	 9eLSYqVXwRPBIopRvphzCG43WIHq8Hj/fD0dz07MHZRg0U34G3nccIk1rz9tb90aC6pQw
	 v1mJ3yVs6fFXejnKy8QOjOyiUJ02mAG2/QgxxI/t4YhiG2mw+C5u4PBRejeHws5iS663k
	 OLfVKEsAf289lyPxWOkcvk7b5DQxjLe55w7Gut2u4NW3YOG+nEdhZzo3Lk3POul8/QITK
	 dNhQRCEkYygEB770Gakg+sOk3/dNndsNdr6jyjspEk+tznZIhJjREObjnqpVQDT8Cpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/ptu9eKd6CbNmjxebzPMpiJtVszjbsUASR3ibR5T8kw=;
	b=w/2py4gUk/WYQcaV8A5g44axquOWCmMmp9+uLuR5DEW56ElU3NE4st8q1uEDVQNiY68c
	 rgbzxCkfmzM0lfu977dbLRLmNn2klwpd17BtJKe/Tl5OIhg5dPN6ZxmS8a0+gZSiYo2pk
	 St7tNe+uAP/vGtZd5TuI+Q7EjhHtpZxqBxTySJF/zvft+3DtfPKWwv95AXyBAslyyqqw3
	 hvOEWLRfzQOaD9E3iR3cnJUJGQU4xDzjylDAG+QH9xXsPWMcleTkIEEqD/j80f5Mdz9NY
	 sARYwocDt1vQ22Ngf9Tq3lcUUtASBl0aaS4hfrRuGNMx0BSXKLAQbxv34wb5Ap9ItLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="iFO/EmQO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF7606A31E
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFDF7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=iFO/EmQO
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c511cdd5a82so367224666b.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:32:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795440731; cv=none;
        d=google.com; s=arc-20260327;
        b=aWJRQqLC89i593r98thxPVb32fU7CWs+uNKm7xVg4FP4UtVVdsHTEP+4J50GSIl/3s
         gF7e4kSqUhcqKkspkOwC8xY2HfTCBqToZEYq3I8U6xoCoJ6o+gOIOSkcsWEzWS7HvpkR
         5JW5neiYz7XY+icfoLii3CyI9h83oygdfzSZbt6ThtRKGJMAPjvWB15AIrl7DCMp19re
         bs5pmGfeNz5ww0Jhi965HvMzRF4pk6MpuIaKmk/SwX0wdny2wDZ0weGdg2+xDokg4xwa
         PeSzz5DVf5umxSGGz02TljJhtMgfq0qHF4SwTGCieTxoL5AAh085ahX14ZNlEuq2+ROo
         PJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ptu9eKd6CbNmjxebzPMpiJtVszjbsUASR3ibR5T8kw=;
        fh=tKQOB2AfmgpIVEKAfeKR3KjQ27gw+DdnQrb+SYkqlco=;
        b=oCCvjr/Ys6+t7erHbBidhnNGRGV6YgSFXCtRry4k/rLeE1Lw+oEKTG1u9NEAm+4Owu
         wIS4iNZFaGG3wl03uMJZjsgveEHJySt/eWF+apDdoMECWKyWHNB7kMIZwVWj0OH+jKe/
         HnBg/9Cf2hP/bk84vPppiHWMxjMMoleK+BF/d0kGRdFd7bM7vX5PrK3WuM0hYVnq2vL3
         NtiMhrQJJmkPqX+05CSSGV1X1WhUY6m9qHrpb7EczKmFn55dCnAe5Vjp4giYT37KdNaO
         kQAOUv9UF2DbFn2sb42Gsd2AHS5NkPHZxDgIgQNva0l385gJS9u6yZHsbgIWeLLkkJ8r
         GIgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795440731; x=1796045531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ptu9eKd6CbNmjxebzPMpiJtVszjbsUASR3ibR5T8kw=;
        b=iFO/EmQOcIGaPYtHOkDTqzdZT1Pa5L0tJ96qApHbhpaovnKIi3E47tWLG4E3f44rzW
         xZqou/M4/dTRWtseRME16zqssDwxBpjL0q3Eh1QF20gD+vjeOBb/z1TuGDuST+r+YsvA
         uJSI7uJ/TRRB7ezlmRzJG5X1dnOHM60JSU42QReRmrqDxtT+3JFW7ZdV0Z+dXXGnk08D
         OJRGDQhGleTjuiwhwg+v0uy/bnbfO86nfOr81PLd4hMemK4D7I/snRJa1/XfxMOTCZNJ
         4PexSQPsrMiU/eJWJzofUX4VC6HI0V2pgk317ONElrIqFAc3x1iLthXIAAM5m1NDw4jg
         x+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440731; x=1796045531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ptu9eKd6CbNmjxebzPMpiJtVszjbsUASR3ibR5T8kw=;
        b=x6+GSgdFP3ivj4FsVYewBilSbwL80PokZ4p28U0bhzxpbgBgbjrkOKVT4a8wKqeLYL
         lV3XJ9+++CZ15TEbqGXAd6VmH6tg3XZ/Ff+/iLVKpRK6sWrDGUzrqeM+fSKgoM+ATCed
         jD5svzASxqj9Iw+/wNk427CjUsL6QPILhIH8opCtjajBPuiTjiAsH4aOrKYbpgb+lc90
         DRI+D9SM2Pnj3JHz2SX1gDIIHVcxZpKmFfYol7r7GagJuDt/jBTGdbg95qZ1VI5gWbXN
         xqA/IW+QdfFCVu9v7ZwqIF/WXyX7GRDZyaKD7Qy0HaWX3+E06KMHtPF/SylkHcACIA2+
         XNTw==
X-Forwarded-Encrypted: i=1; AL+hErFffCugEg8S6H1rTDAI0E/dU8J9l+O61QsPczO/jRZ95rNAS64olTC7JDfHWpNmKHgoGwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wUpFa2/3AlsFVvGnJOjGcSuv8eB52mS/ghcg5ZSOs4sdLGTcL
	NK9VVhgu1+NGhiKwRU0VDXbBSCZITEPkFn9HBJmQWAlU05x2LsBXqPpqaCQ9UK9TxEh+W9Nfe/L
	f61S8o6buYz2fnkVn4eDwmk8el7XjLVHyi9RQp5N/qQ==
X-Gm-Gg: AZFdTZfPk98Dk+5SibNzdYsWzwHpzOn6LCwJuOnZjtntQUjluQ4aPG1EsvkDgRja4mh
	e5zj1PcTtNC8/u/fwKMXnNzDeQdP42lFv/exQe961wlS/C0sSuElnex9e1o8HuYwK3KxXboz5Du
	4ocr7F1v6ug0AXXTxPL7sREEokKMkfEZezuIyXYYMNJxo+ePxbsnxfSnlT8VgITJFy3xdEPoyAt
	MDijwPMAfPQ6er7CT6ai6plxW/mn4D7p61hSaoze2yZOzJTCxrXuJ5o71GJDiCETVBdQKGcG5wJ
	7udFFwlByhnUqTU621k4+syNIXTJGc6gP9vkGnT13+W7tnzvb2ggNnDvXhNeDJScGJkdM6wCqtr
	tg++t2HD2gkcqb8G6daXAJL25c2ylEefp1Mz5RMYHOtRNIRgPo/+CMw6kOVcDLx14Cg==
X-Received: by 2002:a17:906:694f:b0:c50:ff1c:22be with SMTP id
 a640c23a62f3a-c513aace676mr685329866b.16.1795440731316; Mon, 23 Nov 2026
 05:32:11 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-4-max.kellermann@ionos.com> <92bc11db-ef40-48e3-8768-9af36bfb5a7e@linux.alibaba.com>
In-Reply-To: <92bc11db-ef40-48e3-8768-9af36bfb5a7e@linux.alibaba.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 23 Nov 2026 14:31:59 +0100
X-Gm-Features: Aa3M54rFMydpSO212ScIFwe64mMnhlUhUt1F_GHwaP5Pid0tLkWi9Npl8x_Do2s
Message-ID: <CAKPOu+8vso58=3Z8ijpg+91q=BSmJ-M01KyNY=NwUH-9HV_ikA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 11:00=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> > Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
>
> I don't think this fixes anything, right?

Right.  It fixes a performance problem that leads to RCU stalls and
soft lockups, but it's not a bug.  I added the "Fixes" tag for the
commit that added the code responsible for the performance problem,
because I thought that might be helpful and appropriate - is it not?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
