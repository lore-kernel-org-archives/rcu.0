Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F036B11;
	Tue, 13 Aug 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589810; cv=none; b=j2hAu8MvLdhtfHV5WxodzpBVIZ+0SgKEghcbLrcfRUaEjzDZgfstTj1BLlTk3D1IZ7GT6oU43FAmlFTK/N9ZN1DF1dDtSKfbOiGNR1AGnSP+qytdNXybcIt3DvK0Y1WxizVhN39GQ17HVRKa50ngBrzqcdIoD9OD2ddFE/xTMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589810; c=relaxed/simple;
	bh=0zPnoLWCkUohohwETprXTWLzJsDno+a5kFJcw1Eqsd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c09AYt8weJU+ftwM+H+CzcixYjq8YCrF4XXvmQbHHXSv1Mk5cEU4Ug1k3GUFRPHCa0K5H12DLEILqodgQJRAuH+86eRGdoDawU5ooZ7LBL5oWFiUahJPbQVMhIn5l3DM++Tv9grqa6V2RSn8430nHyJbNjIXPn55ekWSNzAWcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LELBtp2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LELBtp2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F688C32782;
	Tue, 13 Aug 2024 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723589810;
	bh=0zPnoLWCkUohohwETprXTWLzJsDno+a5kFJcw1Eqsd0=;
	h=From:To:Cc:Subject:Date:From;
	b=LELBtp2xthB8ShZnV8Jwa8mG8Sq+uszzNhpKdV7W9Vv5xZ5P7mrXzjNlNl3jp2mVx
	 v6Lowu655DSrHDEwNij68tIYHfOKmC8TmwKHvzYA/uwUko4RU1fO8bPOtKR0G1Szi2
	 PyGqv8M+lattD9vmEKjQBSEa7SLAmnLsG+ywQdg1+zwahBZ9hiy/4ZfiyApsFv9R+o
	 Q5A/to8whxBS2nSaP1l0Xin9niZz/rR1QkS7xHfAlvZzniHfPNkrQyTE0lFLi0e4yB
	 QxJjCUhvMbBNyleKiN8jh4ijqKiptZGkRg37axxlP+u+T+fVGKQWGlstQKffOKK8RZ
	 eoVApVwUD9qDQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Cheng-Jui Wang <Cheng-Jui.Wang@mediatek.com>
Subject: [PATCH 0/3] rcu/nocb updates
Date: Wed, 14 Aug 2024 00:56:39 +0200
Message-ID: <20240813225642.12604-1-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series include:

* Fix another RT wake up while CPU is offline (reported by Cheng-Jui Wang)
* Cleanup rcuo wakeup
* Remove another superfluous barrier

Thanks.

Frederic Weisbecker (3):
  rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
  rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
  rcu/nocb: Remove superfluous memory barrier after bypass enqueue

 kernel/rcu/tree_nocb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2

