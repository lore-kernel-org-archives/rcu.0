Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E82E7651
	for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860875; cv=none; b=kdOVYqD4Pgdeuqp9AB730RhtEDhZ51Tv6C7LN7fnoPYdppJTMp3BP7XhwykwsqjDo7iNj9ClRJyyL9MPmMH8Qcx0ZzMSMIedMIA6hBg1ecS5gPc2z1Cegn0C69Hn2m4y+xeJNA/YppDgUCbXYeVRXndhi7TTGJl9MIRnvPtMabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860875; c=relaxed/simple;
	bh=TQ5sIc3/fS9d7as3xkHo1eM8e1rfdQq1Sm4+kNzYGYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJA/8/K7Zla22IoyEAlS+IPTa3PnzVxYWT4jxgy+7/Wm21NPlDC1Jn4fRU799ORmPvFY6aEvDPEMayBmd0qhLzec1CiNXMceTkJuwTOVSQE5+6muKRP4q8FjhsYsVJVi+PGWcW7UVnVu0Pp3yVxojIajce8dGIiMxyOAMzuUamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VImTx7ea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VImTx7ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91FBC4CEED
	for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752860874;
	bh=TQ5sIc3/fS9d7as3xkHo1eM8e1rfdQq1Sm4+kNzYGYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VImTx7ea6LzKv0M4D8DZ7v7F5SIfT6JXEGuIpH/zVRWdnne0A2z4D3GCNO6ADVdt4
	 Qd8MxmHaTwRS0R9ZWr0lDLK2u4C8tT/DqRr9MtwOcQN5Rbva2oWI59tPSDqZ1iyAlJ
	 XAC6dh8gHseLnJrBDv/IyLHTFNxxCfUjqBQtbmbygckpg6LnfA+/Otb4qnewkl3A3c
	 S4EJvl0o7mgx5J73RJ95pike27P7W8drH3dhAinpCYiK/4hYg6MW41VMwk5WMDdtew
	 PNSb6kt626ZhqEk/8Ro442MpRigD/rWsIwMyIWSKm1ih438fjiNna0ZDbhEB1rjzBo
	 FTeq9oJeCvAiw==
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso2046742276.2
        for <rcu@vger.kernel.org>; Fri, 18 Jul 2025 10:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUa0FXg7eYpQPv+exlFxR2ZDUpisG8Jhkq/So0KELKUCVXQv6hs1SfMAHDgTRNbobLByxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BEhIcXHUUC2kTt6CsLSwW9piCoLXrM+59UB+Gpsgx2EJctAc
	boTIzOv3TcWLZwHg396YEVHDhVkSFm5qg6EZlxNjUjxVaI1QXwAo7nDxwaOH3eKKaVAqmswjXhM
	9Y75BKheIbweiSBKaMRN/FYAWMkguHNB9JvmL8jjfJQ==
X-Google-Smtp-Source: AGHT+IGF62ZhB5YEVxaJhGIkN8R80nfFEBJ4r5Kgp5IqfaUZOezsnRw+Vp7jVSibk5FzmxRQifa3Xm+8eZA2J98SRU0=
X-Received: by 2002:a81:ff08:0:b0:718:4095:89bc with SMTP id
 00721157ae682-718409593ffmr101899157b3.22.1752860873623; Fri, 18 Jul 2025
 10:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718024134.1304745-1-ye.liu@linux.dev>
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 18 Jul 2025 10:47:42 -0700
X-Gmail-Original-Message-ID: <CACePvbXi7N9jRNNh0=geG2OsMxoTcvvJSi-kkDVcNcNB=TR54Q@mail.gmail.com>
X-Gm-Features: Ac12FXzRXMWzzyNPLUodypwHPQlgKHKCmCfuuymE3eRodP9xi8uUTMGoTnQeFRM
Message-ID: <CACePvbXi7N9jRNNh0=geG2OsMxoTcvvJSi-kkDVcNcNB=TR54Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 7:42=E2=80=AFPM Ye Liu <ye.liu@linux.dev> wrote:
>
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
>
> No functional change.

Thanks for doing this.

Acked-by: Chris Li <chrisl@kernel.org>

Chris
