Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA1237163
	for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823661; cv=none; b=qareSFMsx716v0ZKG/qU3b3CNkHDB8F9E4poxlJIVt4cpobkeRhy0sdvf/GPNJagQypspHrOPKJ8PjGuWAh32dRA+qMVzwupfpj4Y+6kt4kFS3IyawyRnyG6eMt2Q1kmkBPBk4TqS9XMcAeofN3QNFQe1zqnXeCtWvDlB9hK/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823661; c=relaxed/simple;
	bh=/XI94bxaZF6nsib/YAIic7esxmyqatld+Hbdc/g4KEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT6ghYN4Y/fqOAswA2JX2O7uoYuxWK4NIrkDtRkLrhItYVRe+vg02+CXAVP2d6rWfiGQMF0KvawhNLNYUOjdUi4jxapWPjB//lvaKgmZbQg5bOdusbS4Tr5s1Fxyd0vLRBZo/bZmFiLsucIY2Rx0J9SHUm0wAWkL0JSGwhGyeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt6hRDYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt6hRDYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ALo1+1dcRQ6+1vh0jlFPmWPIJu18nYlSnS7izQm0hI=;
	b=Mt6hRDYVE4G4IsKCd57bbIxR+QLlYiPwC+IBCg9UIXaaZ3qra5vwPYAxxhoGfpvh/NwlqI
	IK65+FI5+X9QaQ/g2ADFJVWRgyCHAkZOsLyOjy36C9y2L7WvBladdc1Dyo1lyFx7sNItTV
	5/qE5sH5o3JjHqZBhBUnDtWndoweGhU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-8HMFpKhvO02_Um8flcyD_A-1; Fri, 18 Jul 2025 03:27:37 -0400
X-MC-Unique: 8HMFpKhvO02_Um8flcyD_A-1
X-Mimecast-MFC-AGG-ID: 8HMFpKhvO02_Um8flcyD_A_1752823656
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a52bfda108so879959f8f.3
        for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 00:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823656; x=1753428456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ALo1+1dcRQ6+1vh0jlFPmWPIJu18nYlSnS7izQm0hI=;
        b=pG1bbHrV629fLTLIi0aFRXS3cwAid19TGmjEIU2bUKH96tDbNQxhOzDUmEClzRZSlc
         R74Wx1xfi4/5wPW66woR5d7gjgHUWvn4Z8pyel71JK93RV+TJseF0c6ncC1C5hAiye2i
         3DFQwFigUGdXGlpuVB2O1QhhsCy2jM4lpzo++tZN875BRefJqIMfryvhH8S1ISLJLCBX
         ffblwjUoTQCBjdVa9pZFz5xiwJcWaVoLA04SXyxalyhEuxLm5j9lJ/DD+U+XmD94bVOy
         x1vhfAJLxq82Q26ljzHlzxIIFA+iZe+WB7l6hPAC0SlapTQ60tsrb7KLHNzp9ODWzIrD
         WP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXasrRtbNBdox2nE/dZabEy59i/ArVVhb+1w/ptbzFKUSqRtMpCYW4XmIoRmPlqm/b+vOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVnUAudj4lttZQ2enZE9c65Unjb8G5Q6AEQmRN+4QBJFBY86+
	+nnL/lLCpBDI6M5SsS41aIGxhz1BHMZsCDyu/4pRVosVzoLl0fMYyMbUh54gEgPcRpviZKen+/6
	VAczD33ne4kzbOtxKVrVcXcD62FHCn+3sHORdLB9zV6LhcaINp4Nd+w==
X-Gm-Gg: ASbGnctMXBXF8X7gDcT+AOavDWGn2SLX9is/k+XhxSj66DY3SnauwWtBNxNelw9+Cdv
	4rKQ2QOy1ULaS3klsmXcF1v17QMoKjOR05piECQygSSbRbOiu1vVZaIvHCTc0NI2nu9wtCQ4tvL
	pGUXUBmL3hiiypKKBlMxnkMIBx41F53b5iMEenvanUz/7V+qFVLzKX2+7B9WW/dvuhXAMOmwV2K
	3vpst8219OzxnH14u+j+0t8oE8zU8Jo+wiCYOV+uO5uofD+6XeLyAJC9zeJZEGA5KlNh+fR70hw
	PGvQxkAnb8mRgf5+CAKzdZWdFhE83YpRNJ9faDUEuQnMNnRF9my4mxaHAk43pbLlFN7zEMkOU6l
	XYO7ou2kIfUgawz0nIcYBdnNtbvXRtCW4xFt0PBJ9Q7RGeJYwazK3ZGKFSKqPB/tRfrg=
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b60dd641d0mr9238123f8f.12.1752823655866;
        Fri, 18 Jul 2025 00:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXY554i1sD7NMWdm3rJHwC0QZPPTqjFIioukZFUaX3RVDz6Fry8yj4tBhWOgvo+CdOVqGVyg==
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b60dd641d0mr9238065f8f.12.1752823655344;
        Fri, 18 Jul 2025 00:27:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a2esm1029324f8f.51.2025.07.18.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:27:34 -0700 (PDT)
Message-ID: <d6767c20-415d-4429-9528-595d029861b0@redhat.com>
Date: Fri, 18 Jul 2025 09:27:32 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20250718024134.1304745-1-ye.liu@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:41, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

