Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B39218ABD;
	Tue, 29 Apr 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934192; cv=none; b=tqTZo8P/ZaaeZg2Xoa7liUkJ6KGGokBymRvg6P+r1Dw1mxceo77+J0gyBBzXFu1e6sQJNP+995bKsgEaOlQma5oP3CfM2YDVZiZ3VM8Tgy/nS+ap+AK9g2hYQTvDXFfO3qxNIwH2aadRJF+3gzwyiEokpXwZIgSj39akqFTCqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934192; c=relaxed/simple;
	bh=awpWUW8mvjtF+SUzNKdmRxVqYYyqG3/AjBsrH4n7waM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3jTyKtZLqzzg24UiQ4jjI30UB4I3dpNZSqS8AN8D31R+3TCrY7K55tAPUh5aVY9ifRDraP0Lzp0rpkuvpFQpT5J6uTaGfouasSOgGzWNdhwEDnmQDQ3tS+sAUClse0I5zWvsAgMUC1YRKM4UbkoTRcGilSWchdZvu9cI70qXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJVqqGVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJVqqGVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F43C4CEE3;
	Tue, 29 Apr 2025 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934191;
	bh=awpWUW8mvjtF+SUzNKdmRxVqYYyqG3/AjBsrH4n7waM=;
	h=From:To:Cc:Subject:Date:From;
	b=HJVqqGVgynNyfLlFHDKUTVX5xGX38NVb4+0wdnAgRCZTcYcOvri1w/8VTe2zEMQ1Y
	 GEe/oaUfb8dQPwg03GeSt8STk43waG7vF5iBLfGS34orXjnzFe8dQ65zpSaQgbaXuz
	 a68L2wWtSYitFq2SLS8gcfABt8feU2MqH80G5qWoHht/qTPn2n+Xbcpz6j96j4PM2w
	 JZVVSgS/MgHrJVwJZpx1h5dt6U3aGTW8LsDt79ReDn33K3Ao0QlMN7/9BVEI1abIsJ
	 s8C4PyVaVAjwz0lGznd3PlgIVG0I1r/ZMiiqOMrzOTu3PO0P9sXuKQnb/EKHvjS/oo
	 Ow9l+V5p5Ltdg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/5 v3] rcu/exp updates
Date: Tue, 29 Apr 2025 15:42:59 +0200
Message-ID: <20250429134304.3824863-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

No real updates in this set. Just collected a few tags.

Thanks.

Frederic Weisbecker (5):
  rcu/exp: Protect against early QS report
  rcu/exp: Remove confusing needless full barrier on task unblock
  rcu/exp: Remove needless CPU up quiescent state report
  rcu/exp: Warn on QS requested on dying CPU
  rcu/exp: Warn on CPU lagging for too long within hotplug IPI's
    blindspot

 kernel/rcu/tree.c        |  8 +++--
 kernel/rcu/tree_exp.h    | 69 +++++++++++-----------------------------
 kernel/rcu/tree_plugin.h |  1 -
 3 files changed, 25 insertions(+), 53 deletions(-)

-- 
2.48.1

