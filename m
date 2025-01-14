Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57928EC6E
	for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847010; cv=none; b=lVxech/XVr7uifQLYDKMFZikkTAc6KR9BLm3W8twTScExdlkLjQo7HvfjTJAExnyZShul0xS+MJHDyYcpBRy1+xTvKivITYUfGQpjrlIkPM2kJzwTVZt0FP14DbpSIBJDJCSMjx9BRQS5vogIVuIBVgfOS75hBIw9g8VUnfqTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847010; c=relaxed/simple;
	bh=Z7+RW9Ce1zoISb8HQk/q0TTOg8DkZTp+QNNQZLVUi7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtws3PTZZVcssmGTjh4r3JMstQ8p7PvRRLHCsWMwMu3Ljh/zkOR+r/skeJpedTc2kiheAkLYaaEMqVSK9tMj9FQnrwd9LUUx1zhurv4sMQNsrCbIxro0f+D9lrLi5IOT0c5OBLE8bNiQQuP2fyjy2AXTNC5Lun9W62qrLCqM2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e9J2YGWq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e9J2YGWq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385deda28b3so2916939f8f.0
        for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736847007; x=1737451807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YGmWmycezS9jkVnxAS2Bxtl3GOSpauTsYhEt8L8EWw=;
        b=e9J2YGWqUEut9Obhk2Os+CMuw8ls7aNSwA865cu5q86qROkVwqpSj6EhIzs1YyhSNH
         O0kbTmT+0aWsmPPVA0zpDmtHQKrKJyG7004maBw5qwJnpVSQac9NTfWB6RunERESluoF
         QpEu+K12rZnBYo42qMF2wodgEb0Nfq3Dn9TqQSCgadROtjgw7e8TPmGYC/bZxe7n/cNO
         De3wbsMTdM4n1VRM9iSs2Kml2vpsidTVhDcKdT8JTENWPvwmT437jWASTMzjisreV3/8
         ZYzcEqet1lSVsf+PaPxXMGSxmBGt1sCL5d4Nj+c5s1paAW0Uo3tu4QW+cBlYj+fm3MiF
         Xkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847007; x=1737451807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGmWmycezS9jkVnxAS2Bxtl3GOSpauTsYhEt8L8EWw=;
        b=J4Q8f6CxtHUQbEdJBC29BXInWiM8bwO+9IsYYfY0AUCCG+VngaohFtoyb670aRJ9jt
         mNcaBhuSgMfhipQVIrUTlA3IXnVeFSYoXBdLzH/mPHiQVLnHdVJflgQeQm8s2gby0VyE
         Pc6sDmTMKqlmW+5rrEDk6H4j7FLbt5BFkfNlj4IB06zndsxGacZ9MHqNJrjQBwb1uyPB
         M7pQEil5+Ppc1w4oTcQpt3Vm1AkTf2zc43WEtjCTLX3m2IzpJ78TqSwRaMMmbuDB/nyZ
         XKaYmTrjFL013I+LXpLL/3nllk53XwPRerhGB43S5WKF9i0NIC1sQJsBsZV50IsB7Alx
         SyNw==
X-Forwarded-Encrypted: i=1; AJvYcCXC5hGdvy25GyosUu6IxB08UQvqzt8LUexpT2JRVCs2cqV+wjuT4EmZB3EdawMqgXy0XXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBM1Vx/O/H0FSRK3/tpWJIPVwWPgm5a1jcE7hn1tvElPSjzGM
	Kcgef+sx/78JlOz8ps8pO8uBpfKfH963rRAqCuP3ehnjJ5XlvPx40K0wXpsJJYk=
X-Gm-Gg: ASbGncs2BK/Od4N5diE5LPHJNIBpEqVyZDPZqfmR8OigCFF//3yj6nWVR2WFmlKy5Eq
	01vYygWgzilqeFQPg49Q4XXbCT8p0KyGP6238u2u/PBR2pxSpx+AkppIYqvfHt+rHcYvvbvDnJv
	C5i6dYNLUDgCGML/0vaVBu2KManU5i6RY9es0UhcDFtQB35cp6aTw003cunUTFaYevo3Ayl7/5n
	VviCy+wbyzQ8nws2+EPJ3kBVlfMV3HaoNqvThsviFLQH/o/En8xxxhPVSEgzUqN2IXKpg==
X-Google-Smtp-Source: AGHT+IGhGtegehO3VtVkIsPaihdSAsIF3SnjAzZnyb48GAvKI0PiF5sJYWYJLFah/z6gYy6ZH3XHeQ==
X-Received: by 2002:adf:b197:0:b0:38a:88b8:99af with SMTP id ffacd0b85a97d-38a88b89a0amr16749637f8f.22.1736847006667;
        Tue, 14 Jan 2025 01:30:06 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm205545485e9.11.2025.01.14.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 01:30:06 -0800 (PST)
Date: Tue, 14 Jan 2025 10:30:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <Z4YunYyj6oqmdrUt@tiehlicka>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka>
 <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>

On Tue 14-01-25 10:20:28, Vlastimil Babka wrote:
> On 1/14/25 09:40, Michal Hocko wrote:
> > On Mon 13-01-25 19:45:46, Andrew Morton wrote:
[...]
> >> > For global OOM, system is likely to struggle, do we have to do some
> >> > works to suppress RCU detete?
> >> 
> >> rcu_cpu_stall_reset()?
> > 
> > Do we really care about those? The code to iterate over all processes
> > under RCU is there (basically) since ever and yet we do not seem to have
> > many reports of stalls? Chen's situation is specific to memcg OOM and
> > touching the global case was mostly for consistency reasons.
> 
> Then I'd rather not touch the global case then if it's theoretical?

No strong opinion on this on my side. The only actual reason
touch_softlockup_watchdog is there is becuase it originally had
incorrectly cond_resched there. If half silencing (soft lock up
detector only) disturbs people then let's just drop that hunk.
-- 
Michal Hocko
SUSE Labs
