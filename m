Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B626D4DE
	for <rcu@vger.kernel.org>; Tue,  2 Dec 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665723; cv=none; b=RwDPdzLol0k4EuDQSIZhfSZ0XXFrFz8iIVB/EJp04ehihM2Sz542ERXExK3QoeqSgw4iK13ienYoNNJM/PXQ9GSZ+MFi/uYXgGIC8eMSFx+rTdMV6k67/ZuB8UAlD2KaCpiuQPeGjHvzp6GRDgwngW3vEoRdG5lWR+SobVnYCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665723; c=relaxed/simple;
	bh=OXSmGRnNXYiolaBmLEqVnw6axmZZPzNuLcO/h/AgF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YziHFSgUEWqX/YelP9dJ2iLiehsoiihaSmMchr1Iqf04pvM+Bquz5Fb281kazM+rkqgh7QlCxDSPwbB7kw1gbSVQa35ObQG06otm6jQZAa50k7xGW8FwOaTyhgBWxjqaijX8UNNXfgh5g3QPp4kjfmZw0uttuhtFBJfSGUmjv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv9EQFm7; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv9EQFm7"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c7660192b0so3813857a34.0
        for <rcu@vger.kernel.org>; Tue, 02 Dec 2025 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764665720; x=1765270520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXSmGRnNXYiolaBmLEqVnw6axmZZPzNuLcO/h/AgF1U=;
        b=Rv9EQFm7+P75yIZZyO6WCHpQw24JhZBULYyur/YBPYFwEvZ++uycJRV+VgoZ98HTma
         vBTqOW7m3EUHcEg0BMNd5OlfRlj4N9d+TY01q255Wnvu3kylfF3n6eo1cixtRk3/SFXd
         PK27hBImVfHApxrKO6WArJHW3UUqQhswbsp6/D/nYx41hER5IZVfLKHwNZllTLcEgMXI
         lwdUKB5WU9mrY1UAawyIONSg1KigcYvL49cNrnblTSXJnPzJ5EwrOKFNwiZ1owx5Q1nz
         wP+cpxY5HzGd7obdSBN649KDrzVVIkYbeaAscmQYPJk25xvb+RV4J+nOaZqNdJgADH90
         RG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665720; x=1765270520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXSmGRnNXYiolaBmLEqVnw6axmZZPzNuLcO/h/AgF1U=;
        b=HBtbktCU4fHR7w2GL7Qz/WFSbMJplnAr8VBXACWHCJqi0akvU5Nwy2GFTJg81gAns8
         6KVpdTvmidEMv1TtkceUZhx3CK62B59F4UtJBvnSbScXrzBPo5ewk8vSBE8g6BEff/OL
         OCESkOBbf2m4uukM41hHGiH7BCO2gCE6vNoh1o2UYtv6iruD/MXpi253zpaKkRSAfoKv
         IvFhB35ESFgbt8pStRQAfTBRcG6uFMxtmpTaPkCIWQwLLlJKRHOhQCoWQTK9glbuC2kZ
         4mnw0FdgVsL0fJDRzdlZd6CwumJHYALXULvyQ5NzBosGTgYR7JutFj7ubC6hFxxDVqT4
         3K0g==
X-Forwarded-Encrypted: i=1; AJvYcCW9+TqbpW9PdpLL1D30pdrOtWpbz5AXlfmDKRKZncxAtbNQ6TZATIZDVH5RkyxeoH0OFu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjwzh6DslelvPYPwjjfHaE//QSk6M/QntHiUhR/gXyiaweTDo3
	VUfaXTZH2CiYHVEUnUHRTK6Av47sruE54UdFwr18I2rlzFQeZCiAO6MsYtRssabZGBAvCgIWHzz
	Vl6Jq4Q+zriKh4ch2H/ZVOwCBRPq5VzE=
X-Gm-Gg: ASbGncsxiCoUK+tJZuG2HsBSWsRmUuPaiTtxrI5JtwFgDBPH1CIrmlFsCZt9cOZ3zXg
	4yTZKCDYM4zPSSmT7TqwhWDdsrgwyuvX83GG9qbvW6kltCvOThWFTXZOMQP09w8q5RAP4aQqc2t
	UtnodKQ+NrPJgqLGtG2fwMHFxv0mKyZPVQhK/PA+LiY1eT6bvbg8aUChF15z3M1wx3aOkXYMIRY
	xkoxsvG6ubcp3BPmla14hCRzOzygFfca+EYz22Kam6VWj0tGYaruuplEpjwsP54aSLUs9X/rA==
X-Google-Smtp-Source: AGHT+IEHuE13vUuoeLGptLbSnrkm6EDrDAgrYaTLHwA6fWA/rKIIRvdg1Qg/eHqHwdn/4++BvLkhnQDBSmouhR/17pc=
X-Received: by 2002:a05:6830:2b21:b0:7c7:5f6e:f269 with SMTP id
 46e09a7af769-7c798f7b99cmr23550694a34.3.1764665720605; Tue, 02 Dec 2025
 00:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz> <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
In-Reply-To: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
From: Hao Li <haoli.tcs@gmail.com>
Date: Tue, 2 Dec 2025 16:55:08 +0800
X-Gm-Features: AWmQ_bmoIQztYjgUhsF_SQ3rxeSlmqGrcHNU5kFx-PhyV7JaekBmHH5actoGVAY
Message-ID: <CAAXMevrpusqiq7w8vYP_PScQ_+SEEUrMf7cFsMnv7M3B2cQnSA@mail.gmail.com>
Subject: Re: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Sorry, my postponed is messed up. I will resend.
