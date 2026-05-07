Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBD35C1A9;
	Thu,  7 May 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176387; cv=none; b=iNgNrSU21gas03goh7CShSpJz3LT9pLDZoTvlZby2cUigDa8I+b0jRkEEDePmYL4KifYQBL2pXh+45BhTaQCLErB9CrXl/aX6TVq214r91ukTcfypM8lKDVLEGebyZJUY/ozUtZqrExcwibfJCxcaJLU4ANxmzzNCWEZP8Craq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176387; c=relaxed/simple;
	bh=nX+hcp7QLMS6Fl3kZQ82Td0f12DD9LtSKWW+sPUOxNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhqdVGQELEOu+1dTY+4v93slw2yF6EDjKI5cWgRAlNAPgx6WDB/CQZ+5dP2mot5Hg8oNU5mxTVbhqj7eBAhNmoBjatvx7ry/Mf3gJlitutWCCULnzuOH9GM5MGHbnUZgRnamTlXxXMxSzOOQKpjzErtLl97LfjWSImwGZ/wQzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3304EC20F1;
	Thu,  7 May 2026 17:44:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 7D46420012;
	Thu,  7 May 2026 17:44:40 +0000 (UTC)
Message-ID: <38a4724712f8bda29fae9d9d838dfe27eb1edb7a.camel@perches.com>
Subject: Re: [PATCH 3/7] checkpatch: Undeprecate rcu_read_lock_trace() and
 rcu_read_unlock_trace()
From: Joe Perches <joe@perches.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
  Puranjay Mohan <puranjay@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,  Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Date: Thu, 07 May 2026 10:44:39 -0700
In-Reply-To: <20260507170950.2040199-3-paulmck@kernel.org>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
	 <20260507170950.2040199-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 34ncz7ptzw9n1pbfgiefr4p57c17g7ze
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7D46420012
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zI5d9q9RO7lDg6eAPsTfxWMkjIPoyogc=
X-HE-Tag: 1778175880-174264
X-HE-Meta: U2FsdGVkX1/u3HxFufyTDUWsLh8lzGF8dOAVKknwXC51S5iWr7UN643/MZtLHWRBTXlg9gtuVz1cvvX5BYGOKF4+zufzcV1qxMhOWtv1hxjvbDJ9BSuJAEqnKxCYrQNtVQ7/o3li46pbqKiPg9wQ96DonUPIOAdaFEdgAtOrgnQFytE1umxh9SlJry+NBjZZSaSdNo1MAvnRmqsUck+2k+7rQ/bY+9xQkFFg0KrkuVcVxerr2TjuVkLXgdbhlHnfy/sZ0qfhMdC08fmNfEUKa4Hxu4dnMyd0dAsDHvFNFyF6qvOHClbe0UzRJsNJY6Ar

On Thu, 2026-05-07 at 10:09 -0700, Paul E. McKenney wrote:
> It turns out that there are BPF use cases that rely on nesting RCU
> Tasks Trace readers.  These use cases are well-served by the old
> rcu_read_lock_trace() and rcu_read_unlock_trace() functions that maintain
> a nesting counter in the task_struct structure.  But these use cases incu=
r
> a performance penalty when using the shiny new rcu_read_lock_tasks_trace(=
)
> and rcu_read_unlock_tasks_trace() functions, which nest in the same way
> that SRCU does.
>=20
> This means that rcu_read_lock_trace() and rcu_read_unlock_trace()
> will be with us for some time.  Therefore, remove the checkpatch.pl
> deprecation.

Fine by me.
Perhaps combining patches 3 and 4 would be more intelligible.
