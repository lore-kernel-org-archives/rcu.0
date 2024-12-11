Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B21F2389
	for <rcu@vger.kernel.org>; Wed, 11 Dec 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959546; cv=none; b=PRkLO6iB/rJEmOHrE3eAwjDnwVrh5VCOl1zpi1dF+1HXFKa6h89N5/wSkq7IoZVAVf+Jygq6bTXWoF/fe7g5pW/Au27heSYQrU7zjxQXfWCLOTgdl7zm7vWhhrFkR5lJ7yr5d4OEomrQMaeosyPOZI9CDWo/QTwHfs61mQUaE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959546; c=relaxed/simple;
	bh=rYJ6Nn2hZfD2FmgqRovHjKX8YBvNNrXN/RvI8Ggve6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c1SIwQu6Z/KYmQ04bPN8VOC5AQ3duyFgCXuRJeeXbeubZrwwm/zwhf2KamQz8UJegyJtbJ7aaoMOU+vUoBUrg6bEJ+gLPI75LPg6AjmIzrZL078K0hYWWdvg8/ZzYw2veQaeBKNjubkydz6AYZMAc8hrKCWcLgYMK1ebICOlZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaDOeMs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaDOeMs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D79EC4CED2;
	Wed, 11 Dec 2024 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733959546;
	bh=rYJ6Nn2hZfD2FmgqRovHjKX8YBvNNrXN/RvI8Ggve6k=;
	h=Date:From:To:Cc:Subject:From;
	b=RaDOeMs1rI29UPSEvfgTSNACTlEQ2LayMXpzQnLvIdoeILXNNZqnhJaI0KzOBs5Kc
	 oqI5HwBg/cYDbhL9VVu5+SVynSY0GX1otKKlK46K5vkTeb1OD3dgYVMzyhCQf6oSXw
	 fekKJNfOv146fbxOuZRHngdopFTiaKGsIjA1nkQQIDPqU+TNvQglHjNv0rdrj2G+O7
	 2cxWsEX8m07bbitDF7ypTiH3E+CAK71D8PbXcE+0KRlYXOATadfcKqAoKAiqkYpaSQ
	 RE2K+wLHSs8W/2NbqPhWH5FBah10Zlz19AqYE7ZoWn5p7Ef0ruW+iCUYG0OvkphbxD
	 +DDz8FOaFmfeg==
Date: Thu, 12 Dec 2024 00:25:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Why is there no list_prev_rcu()?
Message-ID: <kq7lbvk7naxkx4m7mg3bg3dhx6v5py2jinzh33lqusae5n2x7q@hwrfbwlpsbfs>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey Paul,

I have a rather dumb question...

I'm keeping a very boring:

static LIST_HEAD(mnt_ns_list);

of mount namespaces. Userspace can pass a file descriptor for a mount
namespace in that list to the kernel and then open a file descriptor to
the next or previous mount namespace.

As I was working on that I found list_next_rcu() but no
list_prev_rcu(). Which made me curious and then I saw the comment in
commit afa47fdfa29f ("rculist.h: Add list_tail_rcu()").

/**
 * list_tail_rcu - returns the prev pointer of the head of the list
 * @head: the head of the list
 *
 * Note: This should only be used with the list header, and even then
 * only if list_del() and similar primitives are not also used on the
 * list header.
 */

That comment strongly suggests that list_prev_rcu() somehow isn't
generally safe to do? Is that the case and if so why? And what are
possible ways to safely get to the previous list entry under rcu?

(I'm currently doing this in an rbtree via rb_prev() and rb_next() but I
can't do either of those locklessly which is why I want to keep a list
in parallel as well.)

Thanks!
Christian
