Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608056;
	b=l2HWRmj1712ZMLu+t2PRnfXhfxhg4074gXqdnRDiA0XRWpAV8S88hKHw4rMt023BFN4+
	 6F+UGuQpQCeXcHW+aV5XS9bQdJmZOlznV55QZ+rcbWt0fouh1zKsk16g2J+lfETih7k2/
	 N7SdVZxIUFVxpcP0f8w+xB+V3d+H4W3zosbfyr72UAO8cT0UqG7mBIBknD7WUd1Vy3BMT
	 JC/7vBanFvTOzjXWWVYVh1pKJB+qJoeCMl3WMzuVmd77gUai/32sjvskqG1dH2CdN9IWF
	 gnkxCrBSPB+f4sDgiQcUopb0R9HEIET4aYxAgEvPgWDGjqPzWZhjyYSsDPXMUMLXgbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ryxS+aXyH1s0wbz8aqQ7n2ujPhXRrOEtxD9s5b9+KhA=;
	b=J/DuICYUiUlpOmsTm6AShjXepcIbnnzVc5+ezR4PKhmL35hRUEB8iDj8oD/TZ9WpXCK4
	 +A2tDOU+Q71rzBJuhCTjaj4Rzop03g9l3nprWCtXTiMd7AZjg/CdDUomNdKU7euvoF6JW
	 0MaeL5Mj/5g4N0eaWe7+Kps4VB+8tReCtx1dOX3ViCVj3OOtWsX+NlXU1OKr74f/21cru
	 /hjBipIHS/zeak78OkNcFS44RtgW7+xwJkqxpG5dxYnyBHGmURUqUG6Wgfh4J4B+AzyZs
	 e17zESWHE5rXiyBNB2WIjietit+i8dC8GzTZvue805es04R3TPsSqWdodDM4SrrGu0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=bx0SfT1L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E2606A329
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 08:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=bx0SfT1L
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4395d31228so415060366b.1
        for <rcu@vger.kernel.org>; Mon, 02 Nov 2026 00:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793608054; cv=none;
        d=google.com; s=arc-20260327;
        b=WXEo8chn2hW8mQEYSb0HYydIvUsSnXG8IlRLbaD4r4OUs717tZqiz734ykH/mu+7C1
         Qro8OZUZSCT7Srpcq16ehQkPCpDyizpr+f8ujqO2bEn0Nswg+TxzUHQjFzF+97wflNfz
         xVtPUcgrH+jXYIG/JKiHQ9qGn+qXERpvezCCwfTvTLZCtg3JnJT/taFLPgZRIk3pAGjT
         fpfhDjR3URUI2Tn7FuYoJf751UBAh8wtuKkMzUCpdlK4tnVUJSPiWXhMp6yWN/MgbRXu
         VHrpx7iMNmq9Yolc465lgIGOkZvOG1yNm2FAmFmbgRJxm1ZF/SZ49diCveKqb3Odo/yT
         rPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ryxS+aXyH1s0wbz8aqQ7n2ujPhXRrOEtxD9s5b9+KhA=;
        fh=7hmTKnH3Fvv41PY1mLySumVdncwl0DBQEEp7m+cDoh0=;
        b=meuYzsA8WFeIbNCtHNEP5l/znM2Z4Z6cYjfBlY6iBEGAqvPSYPuiWVV7NIwnZ3gSCt
         NcvGpoS2bjm9gucIu4trbDfb2IP+D6Krqqxnc3UozbBWKtGURbxoFVx8AruDQQ6IooB6
         MCDw67uLa0Qch7mRIYqcaw7KyeejIrVwNMzAbMcBNTuueby7bWZySlJu9pPwnV+YQcqe
         V7DsU1+IngqGAYA9jeku/7otWYN5pc8cxf7YZqRzdq9sI+HTerg+9zYmwf530Ab40w70
         Kzv0G0o2Rvxw2gcDICSx+BOYtoE1lMv1pubGLYPK6P4wxeCTsXXYLpvS+r2gMIm0Mtgm
         J6mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793608054; x=1794212854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ryxS+aXyH1s0wbz8aqQ7n2ujPhXRrOEtxD9s5b9+KhA=;
        b=bx0SfT1L6pBzbh7ZAuh6DaL4Tvp609ZPjhHdVhhiwwTCpKaHS8LJjze9UHi0Drgt9z
         g8SXZLy7KuY5DqqA6Na8flRUlFIMgiQb7LDI9J10p//RZ87yEtXsgbnN/aAbRmTPWWzc
         xhAqK/xZQvSZRFAH6gRAobB1k9Qhbq426oLTj5hATLZkN7TyRXUAj1HpJwXz1D0//YDU
         SMh7tKAnHD9GTQO3QZmv1kCBKSKPx86p4YJDdal/MwY4F44u2PKCrFks0L2IMR+TLHVB
         iTQUNlzKJKopGGw4mk9SJeaxK/I2KpTctRE3kYNuF4RsC519mwznOPaqQfrCR5PJQ4Dx
         geOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793608054; x=1794212854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryxS+aXyH1s0wbz8aqQ7n2ujPhXRrOEtxD9s5b9+KhA=;
        b=p8gJsXujAaWsYVn+OJjIeE4zttxLKwbftpvlObas5VyRBrEkpuriuZAdUE7/z0Vkfb
         qMu2RzKCLVHVFwZUbd1BaQ8RpcdxWhLBSaThbpCtEFzUYHwHvoCS9I8xlDaUVVeP5bjJ
         AOZ++6+6Jw4L/Z02U8S5cMyTXqpo52mp20cWNGhMAS1QnofSZgCtgRaqNBWvEzLwvt9R
         LyTUdcjcQAYDkxdh8WKhe1h1hwiNKXBftt5sjEkZur4Uwv/r4gbHPQ1O0Ta6USfZxg8/
         tkANGdPQ+n3FlC7xA0tfCXzby1u26AYhRNu3AFKgiVs6hv84OhZQ6ZiQJEgF6t3BQ0Jh
         wTfg==
X-Forwarded-Encrypted: i=1; AKwUvBxWbVYw1cI8zBs/had6TQhPhcmT7KZJWJH85EFJj3ENWHETfTQYBT6h/7+VQSVOAbF3/2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUzynAmgIOjw7PAcDgY4MIKYE8Ix4/7AWKKzE7L78r5Uw905ri
	Oh31G7TLFtAASCmpn67fFfRoCfgZr/wLDlZugTSSF/WUhvMSvWcd/FO8io56U2BLui5GgdoMRus
	8V0ocTv5yuQkpzmUe/sLrZh7UlOyjweKmtSndAl82bw==
X-Gm-Gg: AYBFou2bVK/9s8TxbfeP2EdPNa2br0rtynNs+EcHLzRjLG/OXEkGiBLGLsqHmrFKKPR
	w406WtPId5PpMv4ciyL0w7P71Gl3HxUqUU4uSVjAxT+HkMi1w2JOJYe9iyZfVZY0FsnSgn7a9I+
	0Nlzi8b2TS8r04M6/+R+FHjnAfwEUhZx9U0JsdsKplonN6ev6iE9Y5LqlTwE3t8FHAsWJpAZGXs
	glbROHki2fJIkWPUcSEz/idU8PRMb4pRRRdHPPWVtnl9H9DIHlNbE0XEoJNRFQE3F1tlQ2Ca/28
	Nb/ksDO8jQHVS/ZFe+EC0jgN7iMIAeLOILrJ9rOHxjYHTUiiJnA+xm78GYC7einezgTfJ+VLOXp
	7wS2YWr/SyEAWrRSvUSKppBD2kDkktRDUborP67FvpRBKSgF/QlUqHGq+uIhEfApkIw==
X-Received: by 2002:a17:907:e84a:b0:c49:901c:d9f with SMTP id
 a640c23a62f3a-c4ca7ad1408mr835701366b.49.1793608054397; Mon, 02 Nov 2026
 00:27:34 -0800 (PST)
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
 <20261012205447.2717801-3-max.kellermann@ionos.com> <CAGsJ_4zQh9HrvgaqD32_A=bSdqmPqP4oV_SxMXMEDBrHe4jjhg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zQh9HrvgaqD32_A=bSdqmPqP4oV_SxMXMEDBrHe4jjhg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 09:27:22 +0100
X-Gm-Features: AclHuK-DaFHs4ZKgRnNWfWDrr2HTqoXucqchR8x0CYIHHdv-rb94RL4ugZac0MU
Message-ID: <CAKPOu+_coR4Z=cbsWOG6zgbSWGvmp4=9=uUphkC3TWTTGn0Pqw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 10:03=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
> T.J. series[1] removed MEMCG_LRU_OLD, i guess you will need some rebase.

Aye, will do if you decide the series is worth merging.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
